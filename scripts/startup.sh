#!/bin/bash

#Thanks to ich777 for this script
echo "---Ensuring UID: 99 matches user---"
usermod -u 99 steam
echo "---Ensuring GID: 100 matches user---"
groupmod -g 100 steam > /dev/null 2>&1 ||:
usermod -g 100 steam
echo "---Setting umask to 000---"
umask 000

echo "---Taking ownership of data...---"
chown -R 99:100 /servers

term_handler() {
	kill -SIGINT $(pidof wineserver)
	tail --pid=$(pidof wineserver) -f 2>/dev/null
	exit 143;
}

echo "---Starting...---"
trap 'kill ${!}; term_handler' SIGTERM
su steam -c "/servers/server.sh" & killpid="$!"
while true
do
	wait $killpid
	exit 0;
done

