#! /bin/bash

#This Bash script makes it easier to go thru log files.  

logFileActions ()
{
	local itemPaths = ($@);
}

mapfile -d $'\0' logPaths < <(find /var/log/* -type f -print0);

keepGoing="1";
while (($keepGoing == 1))
do
	printf "Enter from the following options to view a list of coresponding log files.  : \n 0-Quit \n 1-Show all log file names \n 2-Show auth files  \n 3-Show fail logs \n 4-Show login related files \n 5-Show system log files \n";
	read userInput;
	case $userInput in
	0)
		keepGoing=0;
		echo "Exiting script.  ";
	;;
	1)
		for aLogPath in "${logPaths[@]}"
		do
			echo "$(basename $aLogPath)";
		done
		logFileActions "${logPaths[@]}";
	;;
	2)
		declare -a argumentArray;
		for aLogPath in "${logPaths[@]}"
		do
			if [[ $(echo $aLogPath | grep -i "auth") ]]
			then
				echo "$(basename $aLogPath)";
				argumentArray+=$aLogPath;
			fi
		done
		logFileActions "${argumentArray[@]}";
	;;
	3)
		declare -a argumentArray;
		for aLogPath in "${logPaths[@]}"
		do
			if [[ $(echo $aLogPath | grep -i "faillog") ]]
			then
				echo "$(basename $aLogPath)";
				argumentArray+=$aLogPath;
			fi
		done
		logFileActions "${argumentArray[@]}";
	;;
	4)
		#To do
	;;
	5)
		#To do
	;;
	*)
		echo "Invalid input for prompt.  Please try again.  ";
	;;
	esac
done

