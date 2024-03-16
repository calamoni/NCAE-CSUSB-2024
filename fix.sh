#!/bin/bash

# Define the base directory where user home directories are located
BASE_DIR="/home"

# Loop through all directories in the base directory
for user_dir in "$BASE_DIR"/*; do
    # Check if the entry is a directory
    if [[ -d "$user_dir" ]]; then
        # Get the username from the directory name
        username=$(basename "$user_dir")

        # Set the ownership of all files and directories in the user's home directory
        chown -R "$username:$username" "$user_dir"

        # Set permissions for .ssh directory (if exists)
        ssh_dir="$user_dir/.ssh"
        if [[ -d "$ssh_dir" ]]; then
            chmod 700 "$ssh_dir"
            chown -R "$username:$username" "$ssh_dir"
        fi

        # Set permissions for authorized_keys file (if exists)
        authorized_keys="$ssh_dir/authorized_keys"
        if [[ -f "$authorized_keys" ]]; then
            chmod 600 "$authorized_keys"
            chown "$username:$username" "$authorized_keys"
        fi
    fi
done
