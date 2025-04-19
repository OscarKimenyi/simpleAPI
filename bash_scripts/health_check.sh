#!/bin/bash

# Create log file if it doesn't exist
LOG_FILE="/var/log/server_health.log"
touch $LOG_FILE

# Get current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Function to log messages
log_message() {
    echo "[$TIMESTAMP] $1" >> $LOG_FILE
}

# Check CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
log_message "CPU Usage: $CPU_USAGE%"

# Check Memory usage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
log_message "Memory Usage: $MEM_USAGE%"

# Check Disk space
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
log_message "Disk Usage: $DISK_USAGE%"

# Check if disk space is critical
if [ $DISK_USAGE -gt 90 ]; then
    log_message "WARNING: Disk space is critically low!"
fi

# Check if web server is running (checking for either Apache or Nginx)
if pgrep "apache2" >/dev/null 2>&1 || pgrep "nginx" >/dev/null 2>&1; then
    log_message "Web server is running"
else
    log_message "ERROR: Web server is not running!"
fi

# Check API endpoints
API_BASE="http://localhost"  # Change this if your API runs on a different URL
ENDPOINTS=("/students" "/subjects")

for endpoint in "${ENDPOINTS[@]}"; do
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$API_BASE$endpoint")
    if [ "$HTTP_CODE" -eq 200 ]; then
        log_message "API endpoint $endpoint is working (HTTP 200)"
    else
        log_message "WARNING: API endpoint $endpoint returned HTTP $HTTP_CODE"
    fi
done

log_message "Health check completed"
