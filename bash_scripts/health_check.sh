#!/bin/bash

LOG_FILE="/var/log/server_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEMORY=$(free -m | awk '/Mem:/ {print ($3/$2)*100}')
DISK=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
NGINX_STATUS=$(systemctl is-active nginx)
API1=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/students)
API2=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/subjects)

echo "$TIMESTAMP - CPU: $CPU%, Memory: $MEMORY%, Disk: $DISK%, Nginx: $NGINX_STATUS, /students: $API1, /subjects: $API2" >> $LOG_FILE

if (( $(echo "$DISK > 90" | bc -l) )) || [[ "$API1" -ne 200 ]] || [[ "$API2" -ne 200 ]] || [[ "$NGINX_STATUS" != "active" ]]; then
  echo "$TIMESTAMP - WARNING: Resource issue or API endpoint failed." >> $LOG_FILE
fi
