#!/bin/bash

NOHUP="/usr/bin/nohup"

MATTERMOST_CLIENT="/home/patrick/bin/mattermost-desktop-linux-x64/Mattermost"
PIDGIN="pidgin"
HEXCHAT="/usr/bin/hexchat"
TERM="gnome-terminal --geometry 164x39"
CHROMIUM="chromium"
SUBLIMETEXT="/home/patrick/bin/sublimetext/sublime_text"
ICEDOVE="/usr/bin/icedove"

# ===== "Mattermost"
${MATTERMOST_CLIENT} & 
wid=$(xdotool search --sync --all --onlyvisible --name "Mattermost")
sleep 1

xdotool windowmove $wid 300 50
xdotool windowsize $wid 1200 964
sleep 1
xdotool mousemove --window $wid 500 380 click 1

# ===== "Pidgin"
${PIDGIN} &
sleep 1

# ===== "hexchat"
${HEXCHAT} &
sleep 1
wid=$(xdotool search --sync --all --onlyvisible --name "hexchat")

xdotool mousemove --window $wid 480 480 click 1
sleep 1
xdotool windowsize $wid 1400 920
xdotool windowmove $wid 132 80

# ===== "Terminal 1"
${TERM} &
sleep 1
term1wid=$(xdotool search --sync --all --onlyvisible --class "gnome-terminal" | grep -v $WINDOWID)

xdotool windowmove ${term1wid} 100 175
xdotool windowactivate ${term1wid} key ctrl+shift+t
xdotool key alt+t Right Down KP_Enter
xdotool windowsize ${term1wid} 1450 730

# ===== "Chromium"
xdotool set_desktop 1
${CHROMIUM} &
sleep 1
wid=$(xdotool search --sync --all --onlyvisible --class "chromium" | tail -1)

xdotool windowactivate $wid key Alt_L+F10

# ===== "SublimeText"
xdotool set_desktop 1
${SUBLIMETEXT} &
sleep 1

# ===== "Terminal 2"
xdotool set_desktop 1
${TERM} &
sleep 1
term2wid=$(xdotool search --sync --all --onlyvisible --class "gnome-terminal" | grep -v $WINDOWID | grep -v ${term1wid})

xdotool windowactivate ${term2wid} key Alt_L+F10

# ===== "Icedove"
xdotool set_desktop 0
${NOHUP} ${ICEDOVE} &
sleep 1
