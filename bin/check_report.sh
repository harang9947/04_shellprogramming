#!/bin/bash

INPUTNUM=$1

NUM1=$(echo $INPUTNUM | awk -F- '{print $2}')
NUM2=$(expr $NUM1 + 1)

echo "$NUM1"
echo "$NUM2"

FILE1=/root/bin/report.txt

sed -n "/U-$NUM1/,/U-$NUM2/p" $FILE1 | grep -v "U-$NUM2"