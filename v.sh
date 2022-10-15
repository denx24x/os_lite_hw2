#!/bin/bash
sum=0
last_pid=-1
count=0
while read line;
do
	echo "$line"
	ppid=$(echo "$line" | cut -d: -f2 | cut -d= -f2)
	art=$(echo "$line" | cut -d: -f3 | cut -d= -f2)
	if [ "$last_pid" != "$ppid" ];
	then
		if [ "$last_pid" != "-1" ];
		then
			answer=$(echo "$sum/$count" | bc -l)
			echo "Averate_Running_Children_Of_ParentID=$last_pid is $answer"
		fi
		sum=$art
		count=1
	else
		sum=$(echo "$sum+$art" | bc -l)
		count=$(( count + 1 ))
	fi
	last_pid=$ppid
done < "output.txt" > "output2.txt"

if [ "$last_pid" != "-1" ];
then
	answer=$(echo "$sum/$count" | bc -l)
	echo "Averate_Running_Children_Of_ParentID=$last_pid is $answer" >> "output2.txt"
fi
