#!/bin/bash

# Sensor Names: sensors | grep -E "\+[0-9]{2,3}.[0-9]°C" -n | cut -f2 -d":"
# Sensor Numbers: sensors | grep -E "\+[0-9]{2,3}.[0-9]°C" -n | cut -f1 -d":"

sensors=`sensors | grep -E "\+[0-9]{2,3}.[0-9]°C" -n`

echo "{"
echo "\"data\":["
while read -r sensor;
do
	num=`echo "$sensor" | cut -f1 -d":"`
	name=`echo "$sensor" | cut -f2 -d":"`
	echo "    {\"{#TEMPNUM}\":\"$num\",\"{#TEMPNAME}\":\"$name\"},"
done <<< "$sensors"
echo "]"
echo "}"
