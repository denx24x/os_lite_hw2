#!/bin/bash
for user in $(cat /etc/passwd | cut -d: -f1)
do
	echo "$user"
	ps -u $user | tail -n+2 | awk '{ print $1 }' | paste -sd ','
done
