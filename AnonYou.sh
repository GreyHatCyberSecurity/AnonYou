#!/bin/bash

#=======================================
#Colors
#=======================================
greenf="\033[1;32m"
yellow="\033[33m"
BlueF='\e[1;34m'
end="\033[0m"
red='\e[1;31m'
slimred='\e[0;31m'
#=======================================
banner() {
echo -e "${red}\
 █████╗ ███╗  ██╗ █████╗ ███╗  ██╗██╗   ██╗ █████╗ ██╗   ██╗
██╔══██╗████╗ ██║██╔══██╗████╗ ██║╚██╗ ██╔╝██╔══██╗██║   ██║
███████║██╔██╗██║██║  ██║██╔██╗██║ ╚████╔╝ ██║  ██║██║   ██║
██╔══██║██║╚████║██║  ██║██║╚████║  ╚██╔╝  ██║  ██║██║   ██║
██║  ██║██║ ╚███║╚█████╔╝██║ ╚███║   ██║   ╚█████╔╝╚██████╔╝
╚═╝  ╚═╝╚═╝  ╚══╝ ╚════╝ ╚═╝  ╚══╝   ╚═╝    ╚════╝  ╚═════╝ ${end}"
echo ""
}

checkroot() {
	if (( "$EUID" != 0 ));then
		clear
		echo -e "${slimred}Sorry, I need root to do things.."
		echo -e "All actions provided by the program require root access."
		echo -e "Please use the sudo command or contact your system administrator.${end}"
		exit 1
	else
		clear
		installreq
		torcheck
		privoxycheck
		mac_c_check
		sdmemcheck
		echo "Press [ENTER] to go to main menu!"
		read -p _
		main
	fi
}

installreq() {
	echo "Can I install depencies?(y/n)"
	read -p $'\e[1;31m>>>\e[0m ' caninstall
	case $caninstall in
		y)
		dinstall=1
		;;
		n)
		dinstall=0
		;;
		*)
		echo "Error input, exiting..."
		exit 1
		;;
	esac
}

torcheck() {
	which tor > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
		echo -e "${end}Tor......................[ ${greenf}Found${end} ]"
		torinstalled=1
	elif [ "$?" -ne "0" ];then
		echo -e "Tor...........................[ ${yellow}Not found${end} ]"
		if [ $dinstall -eq "1" ];then
			echo -e "Installing Tor...."
			sudo apt-get install tor -y > /dev/null 2>&1
			which tor > /dev/null 2>&1
			if [ "$?" -eq "0" ];then
				echo -e "${greenf}Succesfully installed Tor${end}"
				torinstalled=1
			else
				echo -e "${yellow}Something went wrong while tor installation...Please, restart the program and try again!${end}"
				torinstalled=0
			fi
		fi
	else
		echo -e "Tor......................[ ${red}Not found${end} ]"
		torinstalled=0
	fi
}

sdmemcheck() {
	which sdmem > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
		echo -e "${end}sdmem......................[ ${greenf}Found${end} ]"
		sdmeminstalled=1
	elif [ "$?" -ne "0" ];then
		echo -e "sdmem...........................[ ${yellow}Not found${end} ]"
		if [ $dinstall -eq "1" ];then
			echo -e "Installing secure-delete...."
			sudo apt-get install secure-delete -y > /dev/null 2>&1
			which sdmem > /dev/null 2>&1
			if [ "$?" -eq "0" ];then
				echo -e "${greenf}Succesfully installed sdmem${end}"
				sdmeminstalled=1
			else
				echo -e "${yellow}Something went wrong while sdmem installation...Please, restart the program and try again!${end}"
				sdmeminstalled=0
			fi
		fi
	else
		echo -e "secure-delete......................[ ${red}Not found${end} ]"
		sdmeminstalled=0
	fi
}

mac_c_check() {
	which macchanger > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
		echo -e "${end}macchanger......................[ ${greenf}Found${end} ]"
		macchangerinstalled=1
	elif [ "$?" -ne "0" ];then
		echo -e "macchanger...........................[ ${yellow}Not found${end} ]"
		if [ $dinstall -eq "1" ];then
			echo -e "Installing macchanger...."
			sudo apt-get install macchanger -y > /dev/null 2>&1
			which macchanger > /dev/null 2>&1
			if [ "$?" -eq "0" ];then
				echo -e "${greenf}Succesfully installed macchanger${end}"
				macchangerinstalled=1
			else
				echo -e "${yellow}Something went wrong while macchanger installation...Please, restart the program and try again!${end}"
				macchangerinstalled=0
			fi
		fi
	else
		echo -e "macchanger......................[ ${red}Not found${end} ]"
		macchangerinstalled=0
	fi
}

privoxycheck() {
	which privoxy > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
		echo -e "${end}Privoxy......................[ ${greenf}Found${end} ]"
		privoxyinstalled=1
	elif [ "$?" -ne "0" ];then
		echo -e "Privoxy...........................[ ${yellow}Not found${end} ]"
		if [ $dinstall -eq "1" ];then
			echo -e "Installing Privoxy...."
			sudo apt-get install privoxy -y > /dev/null 2>&1
			which privoxy > /dev/null 2>&1
			if [ "$?" -eq "0" ];then
				echo -e "${greenf}Succesfully installed Privoxy${end}"
				privoxyinstalled=1
			else
				echo -e "${yellow}Something went wrong while Privoxy installation...Please, restart the program and try again!${end}"
				privoxyinstalled=0
			fi
		fi
	else
		echo -e "Privoxy......................[ ${red}Not found${end} ]"
		privoxyinstalled=0
	fi
}

main() {
	clear
	banner
	sleep 0.01
	echo "[1] Spoof MAC address"
	sleep 0.01
	echo "[2] Enable Tor-bridges"
	sleep 0.01
	echo "[3] Remove rsyslog(dangerous)"
	sleep 0.01
	echo "[4] Secure RAM wiping"
	sleep 0.01
	echo "[5] Secure swap space wiping"
	sleep 0.01
	echo "[6] File shreder"
	sleep 0.01
	echo "[7] User Guide"
	sleep 0.01
	echo "[8] Exit"
	read -p $'\e[1;31m>>>\e[0m ' main_choise
	case $main_choise in
		1)
		if [ $macchangerinstalled -eq "1" ];then
			spoofer
		else
			echo "Seems like you haven't macchanger.."
			echo "Please, install macchanger and try again!"
			echo "Press [ENTER] to return to main menu!"
			read -p _
			main
		fi
		;;
		2)
		if [ $torinstalled -eq "1" ] && [ $privoxyinstalled -eq "1" ];then
			torbridges
		else
			echo "Seems like you haven't tor or privoxy.."
			echo "Please, restart the script and install requiements!"
			echo "Press [ENTER] to return to main menu!"
			read -p _
			main
		fi
		;;
		3)
		remrsyslog
		;;
		4)
		if [ $sdmeminstalled -eq "1" ];then
			wipemem
		else
			echo "Seems like you haven't secure-delete.."
			echo "Please, install secure-delete and try again!"
			echo "Press [ENTER] to return to main menu!"
			read -p _
			main
		fi
		;;
		5)
		if [ $sdmeminstalled -eq "1" ];then
			swapclean
		else
			echo "Seems like you haven't secure-delete.."
			echo "Please, install secure-delete and try again!"
			echo "Press [ENTER] to return to main menu!"
			read -p _
			main
		fi
		;;
		6)
		shreder
		;;
		7)
		userguide
		;;
		*)
		echo "Error input, repeating.."
		sleep 1
		main
		;;
	esac
}

spoofer() {
	clear
	echo "------------------------------------------------------------------------------------------"
	array_test=()
	for iface in $(ifconfig | cut -d ' ' -f1| tr ':' '\n' | awk NF)
	do
        printf "%s\n" "$iface" > /dev/null 2>&1
        array_test+=("$iface")
	done
	echo -e "Available interfaces : ${BlueF}" "${array_test[@]}" "${end}"
	echo "------------------------------------------------------------------------------------------"
	echo ""
	cur_interface=$(ip route show default | awk "/default/ {print $5}")
	cur_mac=$(ifconfig "$cur_interface" | grep -o -E "([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}")
	echo "Changing the MAC-address for your current interface : $cur_interface($cur_mac)"
	echo ""
	echo "If it's right, just press [ENTER] to perform actions"
	echo "If it's not right - please, enter the name of your interface below"
	read -p $'\e[1;31m>>>\e[0m ' int
	case $int in
		"")
		inter=$cur_interface
		;;
		*)
		inter=$int
		;;
	esac
	clear
	banner
	echo "------------------------------------------------------------------------------------------"
	echo "1. Make random MAC address"
	echo "2. Make specified MAC address"
	read -p $'\e[1;31m>>>\e[0m ' whichmac
	case $whichmac in
	1) 
		echo "Performing actions, please wait.."
		macchanger -s "$inter" > /dev/null 2>&1
		ifconfig "$inter" down > /dev/null 2>&1
		macchanger -p "$inter" > /dev/null 2>&1
		ifconfig "$inter" up > /dev/null 2>&1
		macchanger -s "$inter" > /dev/null 2>&1
		newmac=$(ifconfig "$inter" | grep -o -E "([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}")
		echo "Done!"
		echo "Your new mac-address is $newmac"
		echo "Press [ENTER] to return to main menu!"
		read -p _
		main
		;;
	2)
		clear
		echo "Input new MAC address in the next format : 1a:2b:3c:4d:5e:6f"
		read -p $'\e[1;31m>>>\e[0m ' custommac
		echo "Performing actions, please wait..."
		ifconfig "$inter" down > /dev/null 2>&1
		macchanger -m "$custommac" "$inter" > /dev/null 2>&1
		ifconfig "$inter" up > /dev/null 2>&1
		macchanger -s "$inter" > /dev/null 2>&1
		newmac=$(ifconfig "$inter" | grep -o -E "([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}")
		echo "Done!"
		echo "Your new mac-address is $newmac"
		echo "Press [ENTER] to return to main menu!"
		read -p _
		main
		;;
	*)
		echo "Error input, repeating.."
		sleep 1
		spoofer "$@"
		;;
	esac
}

swapclean() {
	clear
	echo "How do you want to wipe the swap space?"
	echo ""
	echo "1. Wipe fast(insecure)"
	echo "2. Wipe secure(slow)"
	echo "3. I've changed my mind, go to main menu!"
	echo "4. Exit"
	read -p $'\e[1;31m>>>\e[0m ' how2wipeswap
	case $how2wipeswap in
		1)
		echo "Unmounting swap devices"
		swapoff -a
		echo "Mounting swap devices"
		swapon -a
		echo "Done! Swap space cleared succesfully"
		echo "Press [ENTER] to return to main menu!"
		read -p _
		main
		;;
		2)
		swapon -s
		echo "Enter your swap device manually(example : /dev/dm-2)"
		read -p $'\e[1;31m>>>\e[0m ' swapdev
		echo "Device : $swapdev selected, unmounting.."
		swapoff -a
		echo "Wiping $swapdev, process may be very slow"
		sswap -v "$swapdev"
		echo "Device $swapdev succesfully wiped, mounting it back.."
		swapon -a
		echo "Done! Press [ENTER] to return to main menu!"
		read -p _
		main
		;;
		3)
		main
		;;
		4)
		exit 0
		;;
		*)
		echo "Error input, repeating.."
		sleep 1
		swapclean
		;;
	esac
}

userguide() {
	clear
	banner
	echo "------------------------------------------------------"
	echo "1. What is TOR?"
	echo "2. What is MAC address and why I need to change it?"
	echo "3. What is RSYSLOG?"
	echo "4. What is RAM wiping?"
	echo "5. What is swap space wiping?"
	echo "6. What is shreder?"
	echo "7. Go back to menu"
	read -p $'\e[1;31m>>>\e[0m ' usg
	case $usg in
		1)
		echo "TOR (The onion router) is a special network of hundreds of computers around the world to anonymize your traffic"
		echo "This network works like this: there are only 3 nodes through which all your traffic before getting to the target server, at the same time imposing a layer of encryption on all traffic (except for the last node on the output), from this came the name 'onion network'"
		echo ""
		echo "More information about Tor you can read on the official site of the developers"
		echo "https://www.torproject.org/"
		echo "Press [ENTER] to return back"
		read -p _
		userguide
		;;
		2)
		echo "MAC is a special 'physical' address of your device (media access control address)"
		echo "Each computer component has its own default MAC address ( mouses, keyboards have their own MAC address as well)"
		echo "MAC address is used for a kind of identification of the device in the network, and system administrators can put 'filters' on the MAC address, thus creating white and black lists"
		echo ""
		echo "An example of such filtering is Wi-Fi. A person can enter in the router settings a list of his own MAC addresses, and only they will be able to connect to the network, and others will not"
		echo "By changing the MAC address, you can bypass some of the 'hardware' blockages, as well as complicate the identification of your devices within the network"
		echo "Press [ENTER] to return back"
		read -p _
		userguide
		;;
		3)
		echo "rsyslog is a special system log that stores information about almost every action of the system"
		echo ""
		echo "On the one hand, it is a very important element for system administrators, allowing them to monitor system usage and timely detect any intrusion attempts or suspicious user activity"
		echo ""
		echo "On the other hand, if you are an ordinary user, you will not need rsyslog very much, because it also takes a lot of space over time and contains information that can be read by intruders"
		echo "Press [ENTER] to return back"
		read -p _
		userguide
		;;
		4)
		echo "Clean up RAM - the process of removing data from RAM and speeding up the system"
		echo "When the system is running, a lot of data is stored in RAM"
		echo ""
		echo "This data is deleted after a system reboot, however, in digital forensics there is a process of 'cold reboot' when RAM is removed from a powered-up computer by freezing (dry nitrogen)"
		echo "It remains switched on for some time, during which it can be connected to a special computer and the RAM dumped, thus compromising all the information from it (including the system's encryption keys)"
		echo ""
		echo "Secure RAM cleanup offers a complete, but not a quick RAM cleanup, thus protecting such data from all possible compromise"
		echo "Press [ENTER] to return back"
		read -p _
		userguide
		;;
		5)
		echo "Swap space wiping is the process of removing data from a special space reserved by the system"
		echo "When you run out of RAM, the data starts to be processed in the swap file, which makes the system run much faster"
		echo ""
		echo "Such files can be read and restored"
		echo "For this purpose, there is a special utility that can safely clear this space, making it impossible to read and restore data from it"
		echo "Press [ENTER] to return back"
		read -p _
		userguide
		;;
		6)
		echo "The shredder is a feature that allows you to irretrievably delete files."
		echo "The function uses the built-in 'shred' utility."
		echo ""
		echo "When you delete a file, it is not actually deleted, but 'invisible' to the system until it is overwritten later."
		echo "A newly deleted file can very easily be recovered with special utilities and equipment."
		echo "Once a file has been overwritten several times (usually about 30) it cannot be recovered"
		echo ""
		echo "shred deletes files by multiple overwrites of the deleted file so it is almost impossible to recover a rewritten file even with very expensive hardware."
		echo "In addition, the file name and size are overwritten, making it impossible to identify the file even if you try to restore it."
		echo ""
		echo "It is worth mentioning that it is strongly not recommended to use this feature when cleaning a file from solid-state drives (SSDs), because SSDs have a different structure than HDDs, which can be irreparably damaged by such overwriting."
		echo "Press [ENTER] to return back"
		read -p _
		userguide
		;;
		7)
		main
		;;
		*)
		echo "Error input, repeating.."
		sleep 1
		userguide
		;;
	esac
}

shreder() {
	clear
	banner
	echo "1. I want to remove all from directory"
	echo "2. I want to remove single file"
	read -p $'\e[1;31m>>>\e[0m ' shredopt
	case $shredopt in
		1)
		echo "Enter or Drag'n'Drop directory path to shred"
		read -p $'\e[1;31m>>>\e[0m ' directory
		#dir2shred=$directory*
		echo "Shredding all from directory $directory, please wait"
		shred -v -f -n 30 -z "$file2shred"
		echo "Done! Press [ENTER] to return to main menu!"
		read -p _
		main
		;;
		2)
		echo "Drag'n'Drop or enter your file to shred"
		read -p $'\e[1;31m>>>\e[0m ' file2shred
		echo "Shredding your file ($file2shred). Please wait.."
		shred -v -f -n 30 -z "$file2shred"
		echo "Done! Press [ENTER] to return to main menu!"
		read -p _
		main
		;;
		*)
		echo "Error input, repeating.."
		sleep 1
		shreder
		;;
	esac
}

wipemem() {
	clear
	banner
	echo "Wiping RAM memory is slow process,but very effective in the sense that after such a rewrite it is almost impossible to 'take out' anything from the RAM."
	echo "But in case, if you want to wipe your RAM fast, select the 2nd option"
	echo "However, some things can be restored if you will select fast option"
	echo ""
	echo "1. Wipe my RAM securely, I have a lot of time"
	echo "2. Wipe my RAM fast(non-secure)"
	echo "3. Do nothing, I've changed my mind. Go to main menu"
	echo "4. Exit"
	read -p $'\e[1;31m>>>\e[0m ' how2wipemem
	case $how2wipemem in
		1)
		wiperamsec
		;;
		2)
		wiperamfast
		;;
		3)
		main
		;;
		4)
		exit 0
		;;
	esac
}

wiperamsec() {
	echo "Wiping your RAM hard, please wait"
	echo "Try to not use your computer now"
	sleep 5
    echo "Dropping your caches.."
    echo 1024 > /proc/sys/vm/min_free_kbytes
    echo 3  > /proc/sys/vm/drop_caches
    echo 1  > /proc/sys/vm/oom_kill_allocating_task
    echo 1  > /proc/sys/vm/overcommit_memory
    echo 0  > /proc/sys/vm/oom_dump_tasks
    echo "Wiping your RAM(may take some time)"
    sdmem -v
    echo "Done! Your RAM is wiped succesfully"
    echo "Shutting down your machine. Have a nice day!"
}

wiperamfast() {
	echo "Wiping your RAM fast, please wait"
	echo "Try to not use your computer now"
	sleep 5
    echo "Dropping your caches.."
    echo 1024 > /proc/sys/vm/min_free_kbytes
    echo 3  > /proc/sys/vm/drop_caches
    echo 1  > /proc/sys/vm/oom_kill_allocating_task
    echo 1  > /proc/sys/vm/overcommit_memory
    echo 0  > /proc/sys/vm/oom_dump_tasks
    echo "Wiping your RAM(may take some time)"
    sdmem -fllv
}

torbridges() {
	clear
	banner
	grep -iRl "forward-socks4a / localhost:9050 ." /etc/privoxy/config > /dev/null 2>&1
	if [ "$?" -eq "0" ] || [ "$?" -eq "130" ];then
		echo "Config already added, starting services.."
		echo "Starting tor service"
		service tor start
		echo "Done"
		echo "Starting privoxy service"
		service privoxy start
		echo "Done!"
		echo "Now, manually add this proxies in your system proxy parameters"
		echo "HTTP Proxy : localhost:8118"
		echo "HTTPS Proxy : localhost:8118"
		echo "SOCKS Proxy : localhost:9050"
		echo "After adding proxy, you visit any site through TOR network!"
		echo "Press [ENTER] to return to main menu!"
		read -p _
		main
	else
		echo "Configuring Privoxy, please wait.."
        {
            echo "forward-socks5 / localhost:9050 ."
            echo "forward-socks4 / localhost:9050 ."
            echo "forward-socks4a / localhost:9050 ."
        } >> /etc/privoxy/config
		echo "Starting tor service"
		service tor start
		echo "Done..."
		echo "Starting privoxy service"
		service privoxy start
		echo "Done!"
		echo "Now, manually add this proxies in your system proxy parameters"
		echo "HTTP Proxy : localhost:8118"
		echo "HTTPS Proxy : localhost:8118"
		echo "SOCKS Proxy : localhost:9050"
		echo "After adding proxy, you visit any site through TOR network!"
		echo "Press [ENTER] to return to main menu!"
		read -p _
		main
	fi
}

remrsyslog() {
	which rsyslogd > /dev/null 2>&1
	if [ "$?" -eq "0" ]; then
		echo "Are you sure that you want to remove rsyslog?"
		echo "In case your system may be hacked, you couldn't check the logs"
		echo "Enter : 'YES REMOVE RSYSLOG' to continue or 'back' to return to main menu"
		read -p $'\e[1;31m>>>\e[0m ' removeornot
		case $removeornot in
			"YES REMOVE RSYSLOG")
				echo "Removing rsyslog, please wait"
				sudo apt-get remove rsyslog -y > /dev/null 2>&1
					which rsyslogd > /dev/null 2>&1
					if [ "$?" -eq "1" ]; then
						echo "Done. rsyslog has been removed succesfully"
						echo "Press [ENTER] to return to main menu!"
						read -p _
						main
					else
						echo "Something went wrong while removing rsyslog"
						echo "Please, try again"
						echo "Press [ENTER] to return to main menu!"
						read -p _
						main
					fi
				;;
			"back")
				main
				;;
			*)
				echo "Error input, going back to main menu!"
				sleep 1
				main
				;;
		esac
	else
		echo "No rsyslog detected, so not removed!"
		echo "Press [ENTER] to return to main menu!"
		read -p _
		main
	fi

}


checkroot

