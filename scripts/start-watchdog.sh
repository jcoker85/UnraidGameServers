#!/bin/bash
killpid="$(pidof SNMASServer.exe)"
while true
do
	tail --pid=$killpid -f /dev/null
	kill "$(pidof tail)"
exit 0
done