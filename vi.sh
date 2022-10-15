#!/bin/bash
for pid in $(ps -eo pid=)
do
	if [ ! -d "/proc/$pid/" ]
	then
		continue
	fi
	vmrss=$(cat "/proc/$pid/status" | awk '$1 == "VmRSS:" {print $2}')
	if [ -z "$vmrss" ]
	then
		continue
	fi
	echo "$pid $vmrss"
done | sort -k2,2 -n | tail -1 | awk '{print "Max memory:" $1 " - " $2}'
echo "Top value: "
top -n1 -b -o RES | grep "COMMAND" -A 1
