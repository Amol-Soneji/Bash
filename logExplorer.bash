#! /bin/bash

#This Bash script makes it easier to go thru log files.  

logFileActions ()
{
	local itemPaths = ($@);
	workOnSameLogType="1";
	while (($workOnSameLogType == 1))
	do
		printf "Enter one of the following options to do actions with the log file names that were previously displayed.  : \n 0-Go back to main menu prompt \n 1-Display file names again \n 2-Search for something in all the log files.  Output will use less, use the q key to get out of less.  \n 3-Search for something in a particular log file.  Output will use less.  \n 4-Delete all log files that are compressed with g-zip \n 5-Delete all old log files and only keep the current one \n";
		read userInput;
		case $userInput in
		0)
			echo "Going back to main menu.  ";
			workOnSameLogType="0";
		;;
		1)
			echo "${itemPaths[@]}";
		;;
		2)
			echo "Enter the text that you want to search for.  :  ";
			read searchInput;
			for aPath in "${itemPaths[@]}"
			do
				less $aPath | grep -i $searchInput;
			done
		;;
		3)
			echo "Enter the name of the file with extension that you which to search in.  :  ";
			read fileName;
			echo "Enter the text that you want to search for.  :  ";
			read searchInput;
			fileFound="0";
			for aPath in "${itemPaths[@]}"
			do
				if [[ $(basename $aPath) == $fileName && (( $fileFound == "0" )) ]]
				then
					less $aPath | grep -i $searchInput;
					fileFound="1";
				fi
			done
			if (( $fileFound == 0 ))
			then
				echo "Error.  The name of the log file the was entered was not found.  ";
			fi
		;;
		4)
			for aPath in "${itempaths[@]}"
			do
				if [[ $(basename $aPath | grep -io ".gz") == ".gz" ]]
				then
					rm $aPath;
				fi
			done
		;;
		5)
			#To do
		;;
		*)
			echo "Invalid input.  Please try again.  ";
		;;
		esac
	done
	#To do
}

mapfile -d $'\0' logPaths < <(find /var/log/* -type f -print0);

keepGoing="1";
while (($keepGoing == 1))
do
	printf "Enter from the following options to view a list of coresponding log files.  : \n 0-Quit \n 1-Show all log file names \n 2-Show auth files  \n 3-Show login related files \n 4-Show dpkg, apt, or related installer or package maintainer logs \n 5-Show OS log files \n 6-Show user log files \n 7-Show Xorg or X related logs \n";
	read userInput;
	declare -a argumentArray;
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
		for aLogPath in "${logPaths[@]}"
		do
			if [[ $(echo $aLogPath | grep -io "auth") == "auth" ]]
			then
				echo "$(basename $aLogPath)";
				argumentArray+=$aLogPath;
			fi
		done
		logFileActions "${argumentArray[@]}";
	;;
	3)
		for aLogPath in "${logPaths[@]}"
		do
			if [[ $(echo $logPath | grep -io "auth") == "auth" || $(echo $logPath | grep -io "wtmp") == "wtmp" || $(echo $logPath | grep -io "lastlog") == "lastlog" || $(echo $logPath | grep -io "faillog") == "faillog" ]]
			then
				echo $(basename $aLogPath);
				argumentArray+=$aLogPath;
			fi
		done
		logFileActions "${argumentArray[@]}";
	;;
	4)
		for aLogPath in "${logPaths[@]}"
		do
			if [[ $(echo $logPath | grep -io "apt") == "apt" || $(echo $logPath | grep -io "dpkg") == "dpkg" || $(echo $logPath | grep -io "installer") == "installer" ]]
			then
				echo $(basename $aLogPath);
				argumentArray+=$aLogPath;
			fi
		done
		logFileActions "${argumentArray[@]}";
	;;
	5)
		for aLogPath in "${logpaths[@]}"
		do
			if [[ $(echo $logPath | grep -io "kern") == "kern" || $(echo $logPath | grep -io "syslog") == "syslog" ]]
			then
				echo $(basename $aLogPath);
				argumentArray+=$aLogPath;
			fi
		done
		logFileActions "${argumentArray[@]}";
	;;
	6)
		for aLogPath in "${logpaths[@]}"
		do
			if [[ $(echo $logPath | grep -io "user") == "user" ]]
			then
				echo $(basename $aLogPath);
				argumentArray+=$aLogPath;
			fi
		done
		logFileActions "${argumentArray[@]}";
	;;
	7)
		for aLogPath in "${logPaths[@]}"
		do
			if [[ $(echo $aLogPath | grep -io "lxdm") == "lxdm" || $(echo $aLogPath | grep -io "Xorg") == "Xorg" ]]
			then
				echo $(basename $aLogPath);
				argumentArray+=$aLogPath;
			fi
		done
		logActions "${argumentArray[@]}";
	;;
	*)
		echo "Invalid input for prompt.  Please try again.  ";
	;;
	esac
done

