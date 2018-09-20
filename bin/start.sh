#!/bin/bash

NOHUP="/usr/bin/nohup"

MATTERMOST_CLIENT="/home/patrick/bin/mattermost-desktop/mattermost-desktop"
FRANZ_CLIENT="/home/patrick/download/internet/install/franz4.0.4/Franz"
PIDGIN="pidgin"
HEXCHAT="/usr/bin/hexchat"
TERM="gnome-terminal --geometry 164x39"
CHROMIUM="chromium"
SUBLIMETEXT="/home/patrick/bin/sublimetext/sublime_text"
THUNDERBIRD="/usr/bin/thunderbird"
NAUTILUS="/usr/bin/nautilus"

## First xterm
startTermWinId=$(xdotool search --sync --all --onlyvisible --class "gnome-terminal")

response=$(zenity --height=400 --list --separator=':' --checklist --title='Selection' --column="-" --column="Soft" \
FALSE "MATTERMOST" \
FALSE "FRANZ" \
FALSE "PIDGIN" \
FALSE "HEXCHAT" \
TRUE "TERM" \
TRUE "CHROMIUM" \
TRUE "SUBLIMETEXT" \
TRUE "THUNDERBIRD" \
TRUE "NAUTILUS" \
)

## ===== "Franz"
if test "${response#*"FRANZ"}" != "$response"; then
	${FRANZ_CLIENT} &
	sleep 1
	wid=$(xdotool search --sync --all --onlyvisible --name "Franz")
	xdotool windowmove $wid 300 50
	xdotool windowsize $wid 1200 964
fi

# ===== "Mattermost"
if test "${response#*"MATTERMOST"}" != "$response"; then
	${MATTERMOST_CLIENT} & 
	wid=$(xdotool search --sync --all --onlyvisible --name "Mattermost")
	sleep 1

	xdotool windowmove $wid 300 50
	xdotool windowsize $wid 1200 964
	sleep 1
	xdotool mousemove --window $wid 500 380 click 1
fi

# ===== "Pidgin"
if test "${response#*"PIDGIN"}" != "$response"; then
	${PIDGIN} &
	sleep 1
fi

# ===== "hexchat"
if test "${response#*"HEXCHAT"}" != "$response"; then
	${HEXCHAT} &
	sleep 1
	wid=$(xdotool search --sync --all --onlyvisible --name "hexchat")

	xdotool mousemove --window $wid 480 480 click 1
	sleep 1
	xdotool windowsize $wid 1400 920
	xdotool windowmove $wid 132 80
fi

# ===== "Terminal 1"
if test "${response#*"TERM"}" != "$response"; then
	${TERM} &
	sleep 1
	term1wid=$(xdotool search --sync --all --onlyvisible --class "gnome-terminal" | grep -v $startTermWinId)

	xdotool windowmove ${term1wid} 100 175
	xdotool windowactivate ${term1wid} key ctrl+shift+t
	xdotool key alt+t Right Down KP_Enter
	xdotool windowsize ${term1wid} 1450 730
fi

# ===== "Chromium"
if test "${response#*"CHROMIUM"}" != "$response"; then
	xdotool set_desktop 1
	${CHROMIUM} &
	sleep 1
	wid=$(xdotool search --sync --all --onlyvisible --class "chromium" | tail -1)

	xdotool windowactivate $wid key Alt_L+F10
fi

# ===== "SublimeText"
if test "${response#*"SUBLIMETEXT"}" != "$response"; then
	xdotool set_desktop 1
	${SUBLIMETEXT} &
	sleep 1
fi

# ===== "Terminal 2"
if test "${response#*"TERM"}" != "$response"; then
	xdotool set_desktop 1
	${TERM} &
	sleep 1
	term2wid=$(xdotool search --sync --all --onlyvisible --class "gnome-terminal" | grep -v $startTermWinId | grep -v ${term1wid})

	xdotool windowactivate ${term2wid} key Alt_L+F10
	xdotool key alt+t Right Down Down KP_Enter
fi

# ===== "Nautilus"
if test "${response#*"NAUTILUS"}" != "$response"; then
	xdotool set_desktop 2
	${NAUTILUS} &
	sleep 1
fi

# ===== "Icedove"
if test "${response#*"THUNDERBIRD"}" != "$response"; then
	xdotool set_desktop 0
	${NOHUP} ${THUNDERBIRD} &
	sleep 1
fi
