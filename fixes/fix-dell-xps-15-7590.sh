#!/usr/bin/env bash

sudo dnf install grubby v4l-utils

#
# Fix issue with suspend
#
# Source: https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Changing_suspend_method
#

sudo grubby --args="mem_sleep_default=deep" --update-kernel=ALL

# Camera settings

# Remove redness from video stream
v4l2-ctl -c saturation=42

# Headphones are not automatically recognized by the system

sudo tee /etc/modprobe.d/dell.conf <<- EOF
	#
	# Created manually on $(date -I) by ${USER}
	#
	# https://bbs.archlinux.org/viewtopic.php?id=222322
	#
	options snd-hda-intel model=dell-headset-multi
EOF

# Disable bluetooth auto-suspend

sudo tee /etc/modprobe.d/btusb.conf <<- EOF
	#
	# Created manually on $(date -I) by ${USER}
	#
	# https://bbs.archlinux.org/viewtopic.php?id=222322
	#
	options btusb enable_autosuspend=0
EOF
