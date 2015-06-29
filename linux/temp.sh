#!/bin/bash

sensors=`sensors | grep -E "\+[0-9]{2,3}.[0-9]°C"`

echo "{"
echo "\"data\":["
#for sensor in "$sensors
while read -r sensor;
do
	temp=`echo "$sensor" | cut -f2 -d"+" | cut -f1 -d"."`
	name=`echo "$sensor" | cut -f1 -d":"`
	echo "    {\"{#TEMPNAME}\":\"$name\",\"{#TEMPERATURE}\":\"$temp\"},"
done <<< "$sensors"
#done
echo "]"
echo "}"
