#!/bin/bash

# This will Auto-configure your Firewall rules 

echo "THIS WILL BE USED FOR ANY DEVICE THAT NEEDS FIREWALL CONFIGURATIONS"

echo "Enter a port that you want to open, IF you are finished with opening your ports press 1 to close the script"

echo -n "Port number to Open: "

read Port

if ["$Port" = '80']; then
        iptables -A INPUT -p tcp --dport 80 -j ACCEPT
fi

if ["$Port" = '53']; then
        iptables -A INPUT -p tcp --dport 53 -j ACCEPT
        iptables -A INPUT -p udp --dport 53 -j ACCEPT
fi

if ["$Port" = '3306']; then
        iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
fi
if ["$Port" = '21']; then
        iptables -A INPUT -p tcp --dport 20 -j ACCEPT
        iptables -A INPUT -p tcp --dport 21 -j ACCEPT
fi

        
# this is only for CentOS
iptables-save > /etc/sysconfig/iptables
