#!/bin/bash
for pid in $(ps -eo pid=)
do
	if [ ! -d "/proc/$pid/" ];
	then
		continue
	fi
	ppid=$(cat /proc/$pid/status | awk '$1 == "PPid:" {print $2}')
	sum_exec_runtime=$(cat /proc/$pid/sched | awk '$1 == "se.sum_exec_runtime" {print $3}')
	nr_switches=$(cat /proc/$pid/sched | awk '$1 == "nr_switches" {print $3}')
	art=$(echo "$sum_exec_runtime/$nr_switches" | bc -l)
	echo "$pid $ppid $art"
done | sort -n -k2,2 | awk '{print "ProcessID=" $1 " : Parent_ProcessID=" $2 " : Average_Running_Time=" $3}' > output.txt

