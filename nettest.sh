#! /bin/bash
#This shell/bash script checks network conectivity.  
#It also displays network info and stats.  
#This script requires the following programs:  
#*NMap
#*ip
#*ss
#*iputils-ping
#*dnsutils

#Set variable defaults.  
pingip="8.8.8.8";
nsname="google.com";

echo "Enter IP address if you wish not to use a default IP address.  Otherwise, leave blank to use default.  ";
read userpingip;
if [ -z $userpingip ]
then
	pingoutput=$(ping -c 5 $pingip);
else
	pingoutput=$(ping -c 5 $userpingip);
fi
echo $(echo $pingoutput | grep -oP '.{0,5}packet loss' | tr -d ',');

echo "Enter website address if you wish not to use default webaddress for DNS test.  otherwise, leave blank to use default.  ";
read userDNSaddress;
if [ -z $userDNSaddress ]
then
	nsoutput=$(nslookup google.com);
else
	nsoutput=$(nslookup $userDNSaddress);
fi
if [ $(echo $nsoutput | grep -io "nxdomain") == "NXDOMAIN" ]
then
	echo "DNS TEST : FAIL";
else
	echo "DNS TEST : PASS";
fi

echo "Enter the number of listening ports you wish to see or test.  If you wish to use defaults for port or socket testing just press enter at prompt.  ";
read numberOfTests;
declare -a prts;
if [ -z $numberOfTests ]
then
	prts[0]="80";
	prts[1]="443";
else
	count=0;
	until (( count > $(($numberOfTests - 1))))
	do
		echo "Enter listening port number for port test number $(($count + 1)) :  ";
		read portInput;
		prts[count]=$portInput;
		((count++));
	done
fi
echo "${prts[@]}";
sockdmp=$(ss -ln);
echo $sockdmp;
for pNumb in "${prts[@]}"
do
	if [[ "$(echo $sockdump | grep -io ":${pNumb} ")" == ":${pNumb} " ]]
	then
		echo "Pass for port $pNumb";
	else
		echo "Fail for port $pNumb";
	fi
done
