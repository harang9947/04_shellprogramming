#!/bin/bash

CMD() {
	sleep 2 ; echo 'user01'
	sleep 1 ; echo 'user01'
	sleep 1 ; echo 'hostname'
	sleep 1 ; echo 'ls -l'
	sleep 1 ; echo 'exit'
}
CMD | telnet localhost 