#!/bin/sh

# Variables
NOW=`date +%s`
PORT=7505
KILLTIME=43200
TMPFILE=/tmp/current-users.vpn

# Test to make sure nc is installed and in a working PATH.
if ! which nc >/dev/null 2>&1; then
        echo "Unable to find the 'nc' binary.  Did you install it?"
        exit
fi

# Test to make sure the OpenVPN management port is listening first.
if ! nc -z localhost $PORT; then
        echo "Unable to reach the OpenVPN management port on $PORT.  Please check you have set the management line in server.conf"
        exit
fi

# Generate a list of connected employees
echo 'status' | nc localhost $PORT | grep ^CLIENT_LIST | sed 's/ //g' > $TMPFILE

date
echo "--------------------------------"
echo "List of current clients"
cat $TMPFILE
echo "--------------------------------"

# Loop through them
for i in `cat $TMPFILE`
do
  	USERID=`echo $i | awk -F ',' '{print $2}'`
        SESSIONID=`echo $i | awk -F ',' '{print $3}'`
        CONNTIME=`echo $i | awk -F ',' '{print $9}'`
        DIFF=$((NOW - CONNTIME))
        DIFFR=$((DIFF / 3600))

        if [ $DIFF -gt $KILLTIME ]; then
                echo "KILLING: User $USERID (Session: $SESSIONID) has been connected $DIFFR hours, killing session."
                echo "kill $SESSIONID" | nc localhost $PORT

        fi

done

# Cleanup
rm -f $TMPFILE
