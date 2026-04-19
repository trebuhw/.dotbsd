#!/bin/sh
birth=$(stat -f %B /var/log/bsdinstall_log)
now=$(date +%s)
secs=$((now - birth))
days=$((secs / 86400))
hours=$(( (secs % 86400) / 3600 ))
printf "%dd %dh\n" $days $hours
