#!/bin/bash

MATTERMOST_CLIENT="/home/LOGIN/bin/mattermost-desktop-linux-x64/Mattermost &"
PIDGIN="pidgin &"
HEXCHAT="/usr/bin/hexchat &"
TERM="gnome-terminal --geometry 164x39 &"


# ===== "Mattermost"
${MATTERMOST_CLIENT}
wid=$(xdotool search --sync --all --onlyvisible --name "Mattermost")
sleep 1

xdotool windowmove $wid 300 50
xdotool windowsize $wid 1200 964
sleep 1
xdotool mousemove --window $wid 500 380 click 1

# ===== "Pidgin"
${PIDGIN}

# ===== "hexchat"
${HEXCHAT}
sleep 1
wid=$(xdotool search --sync --all --onlyvisible --name "hexchat")

xdotool mousemove --window $wid 480 480 click 1
sleep 1
xdotool windowsize $wid 1400 920
xdotool windowmove $wid 132 80

# ===== "Terminal"
${TERM}
sleep 1
wid=$(xdotool search --sync --all --onlyvisible --class "gnome-terminal" | grep -v $WINDOWID)

xdotool windowmove $wid 100 175
xdotool windowactivate $wid key ctrl+shift+t
xdotool windowsize $wid 1450 730