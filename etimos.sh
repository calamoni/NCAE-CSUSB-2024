#!/bin/bash
#
# Script for configuring router if it is a centOS
#
# Take user input
#
echo "THIS SHOULD ONLY BE USED ON CENTOS"

echo "Please enter the interface, ex. eth0 or eth1. You can check what interfaces are available using "ip a"" 

echo -n "Interface: "

read interface

if [ "$interface" = 'eth0' ]; then
	config_file="/etc/sysconfig/network-scripts/ifcfg-eth0"

	sed -i "s/BOOTPROTO=.*/BOOTPROTO="static"/" "$config_file"

  	sed -i "s/ONBOOT=.*/ONBOOT="yes"/" "$config_file"

	echo "Please enter the IP Address"

	echo -n "IP address: "

	read ip_address

		if grep -q "^IPADDR=" "$config_file"; then
		
			sed -i "s/IPADDR=.*/IPADDR=$ip_address/" "$config_file"

		else

			echo "IPADDR=$ip_address" >> "$config_file"
		
		fi	

	echo "Please enter the Subnet mask. ex. 255.255.255.0, 255.255.0.0"

	echo -n "Subnet mask: "

	read netmask

		if grep -q "^NETMASK=" "$config_file"; then

			sed -i "s/NETMASK=.*/NETMASK=$netmask/" "$config_file"

		else

			echo "NETMASK=$netmask" >> "$config_file"

		fi

	echo "Please enter a gateway if applicable, if not applicable just press enter."

	echo -n "Gateway: "

	read gateway_address

		if [ -n "$gateway_address" ]; then

     			if grep -q "^GATEWAY=" "$config_file"; then

 			sed -i "s/GATEWAY=.*/GATEWAY=$gateway_address/" "$config_file"

    			else

       			echo "GATEWAY=$gateway_address" >> "$config_file"

			fi
		fi

elif [ "$interface" == 'eth1' ]; then
	config_file="/etc/sysconfig/network-scripts/ifcfg-eth1"

	sed -i "s/BOOTPROTO=.*/BOOTPROTO="static"/" "$config_file"

  	sed -i "s/ONBOOT=.*/ONBOOT="yes"/" "$config_file"

	echo "Please enter the IP Address"

	echo -n "IP address: "

	read ip_address

		if grep -q "^IPADDR=" "$config_file"; then
		
			sed -i "s/IPADDR=.*/IPADDR=$ip_address/" "$config_file"

		else

			echo "IPADDR=$ip_address" >> "$config_file"
		
		fi	

	echo "Please enter the Subnet mask. ex. 255.255.255.0, 255.255.0.0"

	echo -n "Subnet mask: "

	read netmask

		if grep -q "^NETMASK=" "$config_file"; then

			sed -i "s/NETMASK=.*/NETMASK=$netmask/" "$config_file"

		else

			echo "NETMASK=$netmask" >> "$config_file"

		fi

	echo "Please enter a gateway if applicable, if not applicable just press enter."

	echo -n "Gateway: "

	read gateway_address

		if [ -n "$gateway_address" ]; then

     			if grep -q "^GATEWAY=" "$config_file"; then

 			sed -i "s/GATEWAY=.*/GATEWAY=$gateway_address/" "$config_file"

    			else

       			echo "GATEWAY=$gateway_address" >> "$config_file"

			fi
		fi
else
	echo "Invalid interface."
	exit 1

fi
sudo systemctl restart network

echo "Configuration updated."
