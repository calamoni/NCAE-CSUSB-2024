#!/bin/bash

# This will Auto-configure your Firewall rules 

echo "THIS WILL BE USED FOR ANY DEVICE THAT NEEDS FIREWALL CONFIGURATIONS"

echo "Enter a port that you want to open, IF you are finished with opening your ports press 1 to close the script"

prompt_ports() {
        read -p "Enter Port(s) to open (comma-seperated list): " ports_input
        IFS=',' read -ra ports <<< "$ports_input"

open_ports() {
        for port in "${ports[@]}"; do
                if [[ ! $port = ~ ^[0-9]+$ ]]; then
                        echo "wrong port number: $port'
                        continue
                fi 

                sudo iptables -I INPUT -p tcp --dport "$port" -j ACCEPT
                echo "port $port is opened"

                sudo iptables-save >/etc/iptables/rules.v4
                sudo iptables-save >/etc/iptables/rules.v6
}

prompt_ports
open_ports
                
