#!/bin/bash

# Create log file if it doesn't exist
LOG_FILE="/var/log/update.log"
touch $LOG_FILE

# Get current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Function to log messages
log_message() {
    echo "[$TIMESTAMP] $1" >> $LOG_FILE
}

# Update package list
log_message "Updating package list..."
if apt update >> $LOG_FILE 2>&1; then
    log_message "Package list updated successfully"
else
    log_message "ERROR: Failed to update package list"
    exit 1
fi

# Upgrade packages
log_message "Upgrading packages..."
if apt upgrade -y >> $LOG_FILE 2>&1; then
    log_message "Packages upgraded successfully"
else
    log_message "ERROR: Failed to upgrade packages"
    exit 1
fi

# Pull latest API changes from GitHub
API_DIR="/home/ubuntu/simpleAPI"  # Change this to your actual API directory
log_message "Pulling latest changes from GitHub..."
cd $API_DIR
if git pull >> $LOG_FILE 2>&1; then
    log_message "Git pull successful"
else
    log_message "ERROR: Git pull failed"
    exit 1
fi

# Restart web server (check which one is installed)
if systemctl restart apache2 2>/dev/null; then
    log_message "Apache restarted successfully"
elif systemctl restart nginx 2>/dev/null; then
    log_message "Nginx restarted successfully"
else
    log_message "WARNING: Could not restart web server"
fi

log_message "Update process completed"
