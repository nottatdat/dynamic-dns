#!/bin/bash
. $HOME/.keys/keys.sh
. $HOME/.scripts/utils.sh

if [ ! -f /var/tmp/current_ip ]; then
	LAST_IP=""
else
	LAST_IP=`cat /var/tmp/current_ip`
fi

CURRENT_IP=$(curl -s "https://ipinfo.io/ip" | tr -d '\n')

echo "update_ip.sh|$(date)|IP=$CURRENT_IP" >> /var/tmp/cron_log

if [ "$LAST_IP" != "$CURRENT_IP" ]; then
	update_titan_ip $CURRENT_IP

	echo $CURRENT_IP > /var/tmp/current_ip
fi
