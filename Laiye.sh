#!bin/bash

# THIS WILL BE FOR DEVICES THAT NEED TO HAVE BACK UP FILES 

mkdir /dev/vifo1 

#This is for Debian/Ubuntu

cp /etc/hosts /dev/vfio1
cp /etc/hosts.allow /dev/vfio1
cp /etc/hosts.deny /dev/vfio1
cp /etc/nologin /dev/vfio1
cp /etc/passwd /dev/vfio1
cp /etc/syslogd.conf /dev/vfio1
cp /etc/apache2.conf /dev/vfio1
cp /etc/resolv.conf /dev/vfio1
cp -r /etc/network /dev/vfio1
cp /etc/services /dev/vfio1

#This is for CentOS

cp -r /etc/sysconfig/network-scripts /dev/vfio1
cp -r /etc/sysconfig/network /dev/vfio1
cp -r /etc/firewalld/zones  /dev/vfio1

#this is for transferring the directory to the backup server
select_directory() {
    echo "Select Directory: "
    select dir in */; do 
        if [ -n "$dir"]; then 
            echo "you chose: $dir"
        break
        else
            echo "Invalid selection, try again" 
        fi 
done 
} 

perform_scp() { 
    read -p "enter username@hostname: " remote_host 
    read -p "enter destination directory: " destination

    scp -r "$dir" "remote_host":"destination"
    echo "files copied successfully" 
}



