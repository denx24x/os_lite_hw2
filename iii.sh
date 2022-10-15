#!/bin/bash
ps -eo pid=,lstart= | sort -k2 | tail -1 | awk '{print $1}'
