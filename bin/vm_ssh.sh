# Try to ssh-connect to a virtlib VM from its domain name
# Need sudo access

# ultra specific to my config
mac_pattern="00:ff:8f:81:..:.."
ip_pattern="172.16.81..."

# some constants
VIRSH_BIN="/usr/bin/virsh"
ZENITY_BIN="/usr/bin/zenity"
GREP_BIN="/bin/grep"
SED_BIN="/bin/sed"
SSH_BIN="/usr/bin/ssh"
DOCKER_BIN="/usr/bin/docker"

# get list of running vms
list=$(sudo ${VIRSH_BIN} list --name)

# get list of running docker containers
docker_list=$(docker ps --format "docker:{{.Names}}")

list="${list} ${docker_list}"

# ask the vm you want to connect
vm_name=$(${ZENITY_BIN} --list --title="Running VMs" --column="Choose one to connect" ${list} 2>/dev/null)

if [ -z ${vm_name}  ] ; then
	echo "Bye!\n";
	exit 0;
fi

# ask for <login> or "root" connection
if [ -n "${USER}" ] ; then
	vm_user=$(${ZENITY_BIN} --list --title="Connect as" --column="Choose a user to connect as" "${USER}" "root" 2>/dev/null);
fi

# --- docker
if [[ ${vm_name} == docker* ]]; then
	echo "docker\n"
	# get container name
	container=$(echo ${vm_name} | ${SED_BIN} -e "s/[^:]*:\(.*\)$/\1/")
	echo $container
	# get docker container IP
	ip=$(${DOCKER_BIN} inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${container})

# --- virtlib
else
	# get the MAC address
	mac=$(sudo ${VIRSH_BIN} dumpxml ${vm_name} | ${GREP_BIN} "mac addr" | ${SED_BIN} -e "s/.*\(${mac_pattern}\).*/\1/")

	# get the IP from the MAC, if possible
	ip=$(sudo arp -an | ${GREP_BIN} ${mac} | ${SED_BIN} -e "s/.*\(${ip_pattern}\).*/\1/" | head -1)

	if [ -z "$ip"  ] ; then
		#echo "No IP found, sorry.\n";
		#exit 0;

		# fallback
		# also very specific to my config
		echo "Not found from arp analysis\n"
		id=$(echo ${mac} | cut -d: -f6)
		echo ${id}
		ip="172.16.81.${id}"
		echo ${ip}
	fi
fi

login="root"
if [ ! -z ${vm_user} ] ; then
	login=${vm_user};
else
	if [ -n "$1" ]; then
		login="$1"
	fi
fi

# go
echo "Connection as ${login} on ${ip}"
${SSH_BIN} ${login}@${ip}
