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
	
done
