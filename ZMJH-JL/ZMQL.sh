#!/bin/sh

while :
do

	vbr=$(grep 'user=' /tmp/ZMJH-pppoe.log | grep 'rcvd' | tail -n 1)

	if [ "$vbr"x != "$vbr_old"x ]
	then
		echo "$vbr" >> /tmp/ZHMM.log
		vbr_old="$vbr"
	fi
	sleep 1
	
	#wifi off everyday
	if [ "$(date '+%T' | cut -b 1-7)" == "00:00:0" ]
	then
		wifi down
		sleep 10
	fi

	#wifi on everyday
	if [ "$(date '+%T' | cut -b 1-7)" == "05:00:0" ]
	then
		wifi up
		sleep 10
	fi
	
done
