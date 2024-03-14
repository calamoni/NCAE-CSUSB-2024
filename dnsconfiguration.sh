#!/bin/bash


if [ "$EUID" -ne 0 ]; then
        echo 'script requires root privileges'
        exit 1
fi

echo -e "--------------- \033[1mTESTING IF BIND IS INSTALLED\033[0m ---------------"
echo


if ! command -v named &> /dev/null; then
	echo "BIND IS NOT INSTALLED. INSTALLING........"
	echo 

	if [[ "$(uname)" == "Linux" ]]; then
		if [[ -f /etc/redhat-release ]]; then
			sudo yum install bind bind-utils -y

		elif [[ -f /etc/debian-version ]]; then
			sudo apt-get update
			sudo apt-get install bind9 bind-utils -y 
		else 
			echo "UNSUPPORTED LINUX DISTRIBUTION."
			exit 1
		fi
	fi

	if ! command -v named &> /dev/null; then

		echo "INSTALLATION FAILED.... CHECK LOGS."
		exit 1

	else
		echo '$$$$$$$$$$$$$$$$$$$$$'
		echo "INSTALLTION COMPLETE."
		echo '$$$$$$$$$$$$$$$$$$$$$'
	fi

else 
	echo '$$$$$$$$$$$$$$$$$$$$$$$$$$'
	echo "BIND IS ALREADY INSTALLTED"
	echo '$$$$$$$$$$$$$$$$$$$$$$$$$$'
	echo
fi

echo -n "What is your team number?: "
read team_number
echo -n "What is the DNS IP: "
read ns_ip
echo -n "What is the database IP: "
read db_ip
echo -n "What is the web server IP: "
read www_ip

#touch /etc/bind/team"$team_number".net.zone
	fill_bind_forward() {
echo '$TTL 86400'
echo "@		IN	SOA	ns1.team$team_number.net.	admin.team$team_number.net. ("
echo "			2022031301 ; Serial"
echo "                	3600       ; Refresh"
echo "                	1800       ; Retry"
echo "                	604800     ; Expire"
echo "                	86400 )    ; Minimum TTL"

echo "		IN	NS	ns1.team$team_number.net."

echo " ns1	IN	A	$ns_ip"
echo " db	IN	A	$db_ip"
echo " www 	IN	A 	$www_ip"
}
fill_bind_forward > /etc/bind/team"$team_number".net.zone
	fill_bind_rev() {

rev_dns=$(echo "$ns_ip" | cut -d "." -f 4)
rev_db=$(echo "$db_ip" | cut -d "." -f 4)
rev_www=$(echo "$www_ip" | cut -d "." -f 4) 

echo '$TTL 86400'
echo "@         IN      SOA     ns1.team$team_number.net.       admin.team$team_number.net. ("
echo "                  2022031301 ; Serial"
echo "                  3600       ; Refresh"
echo "                  1800       ; Retry"
echo "                  604800     ; Expire"
echo "                  86400 )    ; Minimum TTL"

echo "          IN      NS      ns1.team$team_number.net."

echo " $rev_dns      IN      PTR       ns1.team"$team_number".net"
echo " $rev_db       IN      PTR       db.team"$team_number".net"
echo " $rev_www      IN      PTR       www.team"$team_number".net"
}

fill_bind_rev > /etc/bind/team"$team_number".net.rev

fill_bind_namedconf() {
echo
echo "zone team"$team_number".net {"
echo "	type master;"
echo "	file "/etc/bind/team"$team_number".net.zone";" 
echo "};"
echo
echo " '<0.255.255.255>.in-addr-.arpa' {"
echo "	type master;"
echo "	file "/etc/bind/team"$team_number".net.rev";"
echo "};"
}
fill_bind_namedconf >> /etc/bind/named.conf.options

echo "Confiuration updated. Please check" 
