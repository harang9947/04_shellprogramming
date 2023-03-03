#!/bin/bash

for i in $(seq 4)
do
    #echo i
    mkdir /test/$i
    for j in 'seq 1 4'
    do
        mkdir /test/$i/$j
    done
done