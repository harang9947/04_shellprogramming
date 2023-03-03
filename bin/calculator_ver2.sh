#!/bin/bash

echo -n "Enter number1 : "
read NUM1

cat << EOF
==============================================
(1) +    (2) -   (3) x   (4) /
==============================================
EOF

echo -n "Enter your choice?(1|2|3|4) : "
read OP

echo -n "Enter number2 : "
read NUM2

case $OP in 
    1) echo "$NUM1 + $NUM2 = $(expr $NUM1 + $NUM2)" ;;
    2) echo "$NUM1 - $NUM2 = $(expr $NUM1 - $NUM2)" ;;
    3) echo "$NUM1 \* $NUM2 = $(expr $NUM1 \* $NUM2)" ;;
    4) echo "$NUM1 / $NUM2 = $(expr $NUM1 / $NUM2)" ;;
    *) echo "[FAIL] 계산실패"; exit ;;
esac