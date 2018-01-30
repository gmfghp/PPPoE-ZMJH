#!/bin/sh

#start pppoe-server
if [ -n "$(ps | grep pppoe-server | grep -v grep)" ]
then
    killall pppoe-server
fi
pppoe-server -k -I br-lan

#clear logs
cat /dev/null > /tmp/ZMJH-pppoe.log
cat /dev/null > /tmp/ZHMM.log

while :
do
	#read the last username in ZMJH-pppoe.log
	var=$(grep 'user=' /tmp/ZMJH-pppoe.log | grep 'rcvd' | tail -n 1)
	name=${var#*'"'}
	username=${name%'" password="'*}
	word=${var#*'" password="'}
	password=${word%'"'*}
	mac=$(grep 'Connected to' /tmp/ZMJH-pppoe.log | grep 'Connected to' | tail -n 1)
	macaddr=${mac:13:17}

	if [ "$username"x != "$username_old"x ]
	then
		ifdown WAN0ZMHQ
		uci set network.WAN0ZMHQ.username="$username"
		uci set network.WAN0ZMHQ.password="$password"
		uci set network.WAN0ZMHQ.macaddr="$macaddr"
		uci commit
		ifup WAN0ZMHQ
		username_old="$username"
		logger -t ZMJH "new username $username"
	fi
	sleep 10

	#close pppoe if log fail
	if [ -z "$(ifconfig | grep "WAN0ZMHQ")" ]
	then
		ifdown WAN0ZMHQ
	else
		sleep 50
	fi
	
	#clear logs everyday
	if [ "$(date '+%T' | cut -b 1-5)" == "00:00" ] || [ "$(date '+%T' | cut -b 1-5)" == "00:01" ]
	then
		cat /dev/null > /tmp/ZMJH-pppoe.log
		cat /dev/null > /tmp/ZHMM.log
		sleep 10
		echo "$var" >> /tmp/ZMJH-pppoe.log
		sleep 10
	fi
	
done
