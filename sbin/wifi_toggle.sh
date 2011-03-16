#!/bin/sh
if [ -d /var/run/hostapd-phy0 -o -d /var/run/hostapd-phy1 ]; then
	/sbin/wifi down
else    
	/sbin/wifi
fi
