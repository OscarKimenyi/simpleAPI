#!/bin/bash

API_DIR="/var/www/my_node_api"
BACKUP_DIR="/home/ubuntu/backups"
LOG_FILE="/var/log/backup.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/api_backup_$(date +%F).tar.gz" "$API_DIR" && \
echo "$TIMESTAMP - API files backup successful." >> "$LOG_FILE" || \
echo "$TIMESTAMP - API files backup FAILED." >> "$LOG_FILE"

# Database backup (for MongoDB example)
mongodump --out "$BACKUP_DIR/mongo_backup_$(date +%F)" && \
echo "$TIMESTAMP - Database backup successful." >> "$LOG_FILE" || \
echo "$TIMESTAMP - Database backup FAILED." >> "$LOG_FILE"

# Delete backups older than 7 days
find "$BACKUP_DIR" -type f -mtime +7 -exec rm {} \;
