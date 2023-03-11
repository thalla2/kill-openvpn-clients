#!/bin/sh

# Variables
NOW=`date +%s`
KILLTIME=60

# Generate a list of connected employees
echo 'status' | nc localhost 7505 | grep ^CLIENT_LIST | sed 's/ //g' > /tmp/current-users.vpn

date
echo "--------------------------------"
echo "List of current clients"
cat /tmp/current-users.vpn
echo "--------------------------------"

# Loop through them
for i in `cat /tmp/current-users.vpn`
do
  	USERID=`echo $i | awk -F ',' '{print $2}'`
        SESSIONID=`echo $i | awk -F ',' '{print $3}'`
        CONNTIME=`echo $i | awk -F ',' '{print $9}'`
        DIFF=$((NOW - CONNTIME))
        DIFFR=$((DIFF / 3600))

        if [ $DIFF -gt $KILLTIME ]; then
                echo "KILLED: User $USERID (Session: $SESSIONID) has been connected $DIFFR hours, killing session."
                echo "kill $SESSIONID" | nc localhost 7505

        fi

done

# Cleanup
rm -f /tmp/current-users.vpn
