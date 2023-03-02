#! /bin/bash

#This script tests and displays stats/info related to the system.  

echo "Disk info: "
df;

echo "Network Info/Tests:"

nettest.sh;
