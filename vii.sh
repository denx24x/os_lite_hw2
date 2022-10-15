#!/bin/bash

for pid in $(ps -eo pid=)
do
	if [ ! -d "/proc/$pid/" ]
	then
		continue
	fi
	readed=$(cat /proc/$pid/io | awk '$1 == "read_bytes:" {print $2}')
	echo "$pid:$readed"
done > tmp.txt
sleep 1m
for line in $(cat tmp.txt)
do
	pid=$(echo "$line" | cut -d: -f1)
	start=$(echo "$line" | cut -d: -f2)
	if [ ! -d "/proc/$pid/" ]
	then
		continue
	fi
	end=$(cat /proc/$pid/io | awk '$1 == "read_bytes:" {print $2}')
	dist=$(($end - $start))
	echo "$pid $dist"
done | sort -k2,2 -n | tail -3
rm "tmp.txt"
