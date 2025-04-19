#!/bin/bash

# Create log file if it doesn't exist
LOG_FILE="/var/log/backup.log"
touch $LOG_FILE

# Get current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Function to log messages
log_message() {
    echo "[$TIMESTAMP] $1" >> $LOG_FILE
}

# Create backups directory if it doesn't exist
BACKUP_DIR="/home/ubuntu/backups"
mkdir -p $BACKUP_DIR

# Backup API files
API_DIR="/home/ubuntu/SimpleAPI"  # Change this to your actual API directory
BACKUP_FILE="$BACKUP_DIR/api_backup_$(date +%F).tar.gz"

if tar -czf $BACKUP_FILE $API_DIR 2>/dev/null; then
    log_message "API backup created successfully: $BACKUP_FILE"
else
    log_message "ERROR: Failed to create API backup"
    exit 1
fi

# Backup database (MySQL example - modify for your database)
DB_BACKUP_FILE="$BACKUP_DIR/db_backup_$(date +%F).sql"

if mysqldump -u username -ppassword database_name > $DB_BACKUP_FILE 2>/dev/null; then
    log_message "Database backup created successfully: $DB_BACKUP_FILE"
else
    log_message "WARNING: Failed to create database backup"
fi

# Delete backups older than 7 days
find $BACKUP_DIR -type f -name "*.tar.gz" -mtime +7 -delete
find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -delete

log_message "Backup process completed"
