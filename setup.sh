#!/bin/bash
end="\033[0m"
slimred='\e[0;31m'
greenf="\033[1;32m"


if (( "$EUID" != 0 ));then
	echo -e "${slimred}Sorry, you need root access to install AnonYou.."
	echo -e "Please, use root account/'sudo' command or contact your system administrator${end}"
	exit 1
else
	echo "Checking if you already installed AnonYou.."
	sleep 1
	which AnonYou > /dev/null 2>&1
	if [ "$?" -eq "0" ];then
		echo -e "${greenf}You have already installed AnonYou script"
		echo -e "Run : 'sudo AnonYou' in terminal to run the script(you can use -f arguement to force start)${greenf}"
		exit 0
	else
		echo "-----------------------------------------------------"
		echo -e "${slimred}Not found...${end}"
		echo "Installing AnonYou script directly into your system, please wait"
		sleep 1
		cp AnonYou /bin
		cp things.txt /bin
		clear
		echo -e "${greenf}Done! Now you can run the AnonYou script simply by typing one command"
		echo -e "'sudo AnonYou' (you can use -f arguement to force start)"
		echo -e "Have a nice day!${end}"
		exit 0
	fi
fi
