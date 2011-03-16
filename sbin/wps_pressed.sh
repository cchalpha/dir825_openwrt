#!/bin/sh
pid_file=/tmp/`basename $0`.pid
wps_led=/sys/class/leds/dir825b1:blue:wps
orange_power_led=/sys/class/leds/dir825b1:orange:power

restore_leds_default() {
	led_on $orange_power
	lsmod | grep nfsd
	if [ $? -eq 0 ]; then
		led_on $wps_led
	else
		led_off $wps_led
	fi
}

exit_on_signal() {
	rm $pid_file
	restore_leds_default
	exit 0
}

led_on() {
	echo 1 > $1/brightness
}

led_off() {
	echo 0 > $1/brightness
}

all_leds_off() {
	led_off $wps_led
	led_off $orange_power_led
}

trap exit_on_signal SIGTERM SIGINT

[ -f $pid_file ] && exit 0
echo $$ > $pid_file

while true; do
	all_leds_off
	sleep 1
	led_on $wps_led
	sleep 1
	led_off $wps_led
	led_on $orange_power_led
	sleep 1
done
