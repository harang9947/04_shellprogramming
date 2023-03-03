#!/bin/bash

for i in $(cat file1)
do
    echo $i
done    

cat file1 | while read 
do
    echo $j
done