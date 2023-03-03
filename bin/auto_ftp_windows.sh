#!/bin/bash

IP1=172.16.6.18
PORT=21

ftp -n $IP1 $Port <<EOF
user user01 user01
cd share
lcd /test
bin
hash
prompt
mput s1.txt
quit
EOF
