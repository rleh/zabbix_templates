#!/bin/bash

# Sensor Names: sensors | grep -E "\+[0-9]{2,3}.[0-9]°C" -n | cut -f2 -d":"
# Sensor Numbers: sensors | grep -E "\+[0-9]{2,3}.[0-9]°C" -n | cut -f1 -d":"

sensors=`sensors | grep -E "\+[0-9]{2,3}.[0-9]°C" -n`

NEWLINE=$'\n'
TAB=$'\t'
ITEMS=""
while read -r sensor;
do
	num=`echo "$sensor" | cut -f1 -d":"`
	name=`echo "$sensor" | cut -f2 -d":"`
	#echo "    {\"{#TEMPNUM}\":\"$num\",\"{#TEMPNAME}\":\"$name\"},"
	ITEMS="$ITEMS$TAB  {\"{#TEMPNUM}\":\"$num\",\"{#TEMPNAME}\":\"$name\"},"
done <<< "$sensors"
ITEMS=$(echo "$ITEMS" | rev | cut -c 2- | rev)
ITEMS=$(echo "$ITEMS" | sed 's/\t/\n/g' )
echo "{\"data\":[$ITEMS$NEWLINE]}"
