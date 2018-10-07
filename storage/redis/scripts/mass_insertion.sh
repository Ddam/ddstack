#!/usr/bin/env bash

while IFS= read -r line
do
    for i in `seq 1 $2`
    do
        newline="${line/items:%d:/items:${i}:}"
        echo "${newline/\"id\": %d,/\"id\": ${i},}" >> import.txt
    done
done < $1

cat import.txt | redis-cli --pipe -a REDIS_PASSWORD
rm -f import.txt
