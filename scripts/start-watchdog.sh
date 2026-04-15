#!/bin/bash
killpid="$(pidof WindroseServer-Win64-Shipping.exe)"
while true
do
	tail --pid=$killpid -f /dev/null
	kill "$(pidof tail)"
exit 0
done