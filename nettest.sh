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


pingoutput=$(ping -c 5 8.8.8.8);
echo $(echo $pingoutput | grep -oP '.{0,5}packet loss' | tr -d ',');


nsoutput=$(nslookup google.com);
if [$(echo $nsoutput | grep -io "nxdomain") == "NXDOMAIN"]
then
	echo "DNS TEST : FAIL"
else
	echo "DNS TEST : PASS"
fi
