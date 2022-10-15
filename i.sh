#!/bin/bash
ps -u "user" | awk '{print $1, $4}'
