#!/bin/bash

# shout out chatGPT for this one


# Array of allowed usernames

if [ "$EUID" -ne 0 ]; then
        echo 'script requires root privileges'
        exit 1

allowed_usernames=(
    "khanmigo"
    "myai"
    "tabcomplete"
    "gpt"
    "cortana"
    "codewhisperer"
    "claude"
    "musico"
    "chatbot"
    "codeium"
    "tabnine"
    "copilot"
    "watson"
    "tensorflow"
    "bard"
    "pytorch"
    "caffe2"
    "midjourney"
    "dalle"
    "llama"
    "theano"
    "aiva"
    "siri"
    "ytemr"
)

# Get all existing users (excluding system service accounts)
all_users=$(awk -F: '($3>=1000)&&($1!="nobody"){print $1}' /etc/passwd)

# Loop through each user
for username in $all_users; do
    # Check if the user is in the allowed list
    if [[ " ${allowed_usernames[@]} " =~ " $username " ]]; then
        # User is in the allowed list, keep the same shell
        echo "Keeping shell as default for user: $username"
    else
        # User is not in the allowed list, set the shell to /bin/rbash
        usermod -s /bin/rbash "$username"
        echo "Shell set to /bin/rbash for user: $username"
    fi
done
