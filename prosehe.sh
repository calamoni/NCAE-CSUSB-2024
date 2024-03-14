#!/bin/bash
#
LOG_FILE="/var/log/system_network.log"

echo "Enter the log that you wish."
echo "1. tcp/udp"
echo "2. system"
echo "3. etc"
echo "4. userps"

echo -n "Log: "

read log 

if [ $log = '1' ]; then 

collect_tcp_udp_info() { 
        echo "=============== Network Information ==============="
        echo "Date: $(date)"
        echo "---------------------------------------------------"
        ifconfig -a 
        echo "---------------- ALL TCP PORTS --------------------"
        ss -t 
        echo "---------------- ALL UDP PORTS---------------------"
        ss -u  
        echo "------------- ALL LISTENING PORTS -----------------"
        ss -l | grep -e tcp -e udp
        echo "---------------------------------------------------"
        echo
}

while true; do 
        { collect_tcp_udp_info; }
        sleep 5 

done

elif [ $log = '2' ];  then


collect_system_info() {
        echo "=============== System Information ==============="
        echo "Date: $(date)" 
        echo "--------------------------------------------------"
        uname -a
        echo "--------------------------------------------------"
        df -h 
        echo "--------------------------------------------------"
        free -h 
        echo "--------------------------------------------------"
        uptime 
        echo "--------------------------------------------------"
        echo

}

while true; do
        { collect_system_info; } 
                sleep 5

        done

elif [ $log = '3' ]; then

        collect_etc_info() {
        echo "=============== ETC ==============="
        echo "Date: $(date)"
        echo "-----------------------------------"
        ss -aux 
        echo "-----------------------------------"
        uptime 
        echo "-----------------------------------"
        echo 
}
while true; do
        { collect_etc_info; }
                sleep 5 

        done 
elif [ $log = '4' ]; then
        collect_user_info() {
                echo "=============== User process information =============="
                echo "Date: $(date)"
                echo "-------------------------------------------------------"
                ps -eo pid,uid,args | awk '$2 >= 1000' 
                echo "-------------------------------------------------------"
                uptime 
                echo "-------------------------------------------------------"
                echo
        }
        while true; do
                { collect_user_info; }
                sleep 45
        done 

fi

