#!/bin/sh
wps_pressed_pid_file=/tmp/wps_pressed.pid
wps_led=/sys/class/leds/dir825b1:blue:wps
orange_power_led=/sys/class/leds/dir825b1:orange:power

[ ! -f $wps_pressed_pid_file ] && exit 0

if [[ `echo $wps_led` gt 0 ]]; then
	logger "WPS Switch: wifi toggle."
	/sbin/wifi_toggle.sh
elif [[ `echo $orange_power_led` gt 0 ]]; then
	logger "WPS Switch: nfs mount."
	#
fi

kill `echo $wps_pressed_pid_file`

