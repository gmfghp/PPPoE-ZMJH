#!/bin/sh

#start pppoe-server
if [ -n "$(ps | grep pppoe-server | grep -v grep)" ]
then
    killall pppoe-server
fi
pppoe-server -k -I br-lan

#clear logs
cat /dev/null > /tmp/ZMJH-pppoe.log

while :
do
	#read the last username in ZMJH-pppoe.log
	var=$(grep 'user=' /tmp/ZMJH-pppoe.log | grep 'rcvd' | tail -n 1)
	name=${var#*'"'}
	username=${name%'" password="'*}
	word=${var#*'" password="'}
	password=${word%'"'*}

	if [ "$username" != "$username_old" ]
	then
		ifdown WAN0ZMHQ
		uci set network.WAN0ZMHQ.username="$username"
		uci set network.WAN0ZMHQ.password="$password"
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
	fi

done
