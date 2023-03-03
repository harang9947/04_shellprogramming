#!/bin/bash

cat /root/bin/server.txt | while read IP1 UNAME UPASS
do
	CMD() {
		sleep 2 ; echo "$UNAME"
		sleep 1 ; echo "$UPASS"
		sleep 2 ; echo 'hostname'
		sleep 2 ; echo 'date'
		sleep 1 ; echo 'exit'
	}
	CMD | telnet $IP1
done