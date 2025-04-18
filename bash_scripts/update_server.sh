#!/bin/bash

LOG_FILE="/var/log/update.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
API_DIR="/var/www/my_node_api"

echo "$TIMESTAMP - Starting server update..." >> "$LOG_FILE"
sudo apt update && sudo apt upgrade -y >> "$LOG_FILE" 2>&1

cd "$API_DIR"
if git pull >> "$LOG_FILE" 2>&1; then
  echo "$TIMESTAMP - Git pull successful." >> "$LOG_FILE"
  systemctl restart nginx && echo "$TIMESTAMP - Nginx restarted." >> "$LOG_FILE"
else
  echo "$TIMESTAMP - Git pull failed. Aborting update." >> "$LOG_FILE"
  exit 1
fi
