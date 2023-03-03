#!/bin/bash
#   # cat hosts.txt
#   192.168.10.10   server10.example.com    server10
#   192.168.10.11   server11.example.com    server11
#   .....
#   192.168.10.30   server30.example.com    server30

HOSTS=/etc/hosts   #(임시파일 사용하다가 완성하면 적용)
#HOSTS=/root/bin/hosts && > $HOSTS #테스트용 임시파일

NET=192.168.10
START=10
END=20

C_IP=$(ip addr show ens33 | grep -w inet | awk '{print $2}' | awk -F/ '{print $1}' | awk -F. '{print$4}')

for i in $(seq $START $END)
do
    [ $C_IP -eq $i ] && continue
    echo "$NET.$i   server$i.example.com    server$i" >> $HOSTS
done