#!/bin/bash
#
# Search for all users available on the system and output to a file
#
echo -e "\033[1mAll available users\033[0m"
#
cat /etc/passwd | cut -d ':' -f 1 
#
# Search for all users with a shell
#
echo -e "\033[1mAll available users with a shell\033[0m" 

cat /etc/passwd | grep -e /bin/bash -e /bin/zsh -e /bin/sh | cut -d ':' -f 1 

echo -e "\033[1mAll network services that are listening and running\033[0m"

netstat -lp

netstat -lp > ~/netstat.txt
#
