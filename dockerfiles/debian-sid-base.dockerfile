FROM  debian:sid

RUN apt-get update && \
    apt-get install -y \
	subversion  \
	build-essential \
	automake \
	make \
	gcc \
	g++ \
	less \
	vim \
	bzip2 \
	tar \
	psmisc \
	net-tools \
	whois \
	iftop \
	tcpdump \
	nmap \
	openssh-server \
	unzip \
	git \
	tig \
	wget \
	curl && \
	echo "alias l='ls -Al'" >>  /root/.bashrc

CMD ["bash"]


