#!/bin/bash

# shout out chatGPT once again!!! if urmad about that, please leave it in the suggestion box and I'll get to it later(no I won't). 


# Source directory

if [ "$EUID" -ne 0 ]; then
        echo 'script requires root privileges'
        exit 1
fi
source_dir="/mnt/files"

# Destination directory for backup
echo "PUT THE DIRECTORY WHERE YOU WANT IT BACKED UP"
echo -n "Directory: "
read backup_dir

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Loop through each .bin file in the source directory
for file in "$source_dir"/*.bin; do
    # Check if the file exists
    if [ -f "$file" ]; then
        # Extract the filename without the path
        filename=$(basename "$file")
        
        # Backup the file to the destination directory
        cp "$file" "$backup_dir/$filename"
        
        # Check if the backup was successful
        if [ $? -eq 0 ]; then
            echo "Backup completed for file: $filename"
        else
            echo "Backup failed for file: $filename"
        fi
    fi
done

