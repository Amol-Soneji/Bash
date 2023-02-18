#This shell/bash script checks network conectivity.  
#It also displays network info and stats.  
#This script requires the following programs:  
#*NMap
#*ip
#*ss
#*iputils-ping
#*dnsutils



pingoutput=$(ping -c 5 8.8.8.8);
echo $(echo $pingoutput | grep -oP '.{0,5}packet loss' | tr -d ',');


nsoutput=$(nslookup google.com);

