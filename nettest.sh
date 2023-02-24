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
if [$(echo $nsoutput | grep -io "nxdomain") == "NXDOMAIN"]
then
	echo "DNS TEST : FAIL"
else
	echo "DNS TEST : PASS"
fi
