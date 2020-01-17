#!/bin/bash

Trace() {
echo "####################################################"
echo "##----Script to Disable Trace HTTP on IN nodes----##"
echo "##----Name:Issahaku Kamil | UserID : EKAMISS------##"
echo "####################################################"

ExtrTimeStamp=$(date "+%Y-%m-%d_%H-%M-%S");
echo ""
echo "Note the Date-Time-Stamp in case of a rollback:$ExtrTimeStamp"
echo ""

echo ""
echo "Do you want to disable HTTP trace? yes/no. It is advisable to do so according to MBSS"
echo ""
read trace
trace=${trace^^}
if [[ "$trace" == "YES" ]]
then 
	echo "Disabling HTTP trace.."
	if grep -Fxq "TraceEnable off" /etc/httpd/conf/httpd.conf
	then
		echo "HTTP trace disabled successfully"
	else
		echo "TraceEnable off" >> /etc/httpd/conf/httpd.conf
	fi
elif [[ $trace="no" ]]
then
	echo "Aborting Operation.."
else
	echo "exit status=$status"
fi
. rollback.sh
roll
}

