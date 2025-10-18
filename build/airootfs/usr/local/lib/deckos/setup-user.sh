#!/bin/bash
# User account creation module

setup_user() {
    while true; do
        # Get username
        dialog --title "Create Your Account" \
               --inputbox "Enter username (lowercase, no spaces):" 10 50 \
               2> /tmp/username
        
        if [ $? -ne 0 ]; then
            return 1
        fi
        
        USERNAME=$(cat /tmp/username)
        
        # Validate username
        if [[ ! "$USERNAME" =~ ^[a-z][a-z0-9_-]*$ ]]; then
            dialog --title "Invalid Username" \
                   --msgbox "Username must start with lowercase letter\n\
and contain only lowercase letters, numbers, - and _" 8 50
            continue
        fi
        
        # Get password
        dialog --title "Set Password" \
               --insecure --passwordbox "Enter password (min 8 characters):" 10 50 \
               2> /tmp/password1
        
        PASSWORD1=$(cat /tmp/password1)
        
        if [ ${#PASSWORD1} -lt 8 ]; then
            dialog --title "Password Too Short" \
                   --msgbox "Password must be at least 8 characters" 7 50
            continue
        fi
        
        # Confirm password
        dialog --title "Confirm Password" \
               --insecure --passwordbox "Confirm password:" 10 50 \
               2> /tmp/password2
        
        PASSWORD2=$(cat /tmp/password2)
        
        if [ "$PASSWORD1" != "$PASSWORD2" ]; then
            dialog --title "Passwords Don't Match" \
                   --msgbox "Passwords do not match. Try again." 7 50
            continue
        fi
        
        break
    done
    
    # Create user
    useradd -m -G wheel,audio,video,input,storage -s /bin/zsh "$USERNAME"
    echo "$USERNAME:$PASSWORD1" | chpasswd
    
    # Save to config
    echo "USERNAME=$USERNAME" >> /etc/deckos/setup.conf
    
    # Cleanup
    rm -f /tmp/username /tmp/password1 /tmp/password2
    
    dialog --title "Account Created" \
           --msgbox "User account '$USERNAME' created successfully!" 7 50
}
