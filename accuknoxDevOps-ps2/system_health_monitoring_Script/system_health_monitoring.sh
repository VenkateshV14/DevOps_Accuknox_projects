#!/bin/bash

# ==============================
# System Health Monitoring Script
# ==============================

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
PROC_THRESHOLD=200
LOG_FILE="/var/log/system_health.log"

# Ensure log file exists
touch $LOG_FILE

# Function to log alerts
log_alert() {
    local MESSAGE=$1
    echo "$(date +"%Y-%m-%d %H:%M:%S") - ALERT: $MESSAGE" | tee -a $LOG_FILE
}

# Function to log normal status
log_info() {
    local MESSAGE=$1
    echo "$(date +"%Y-%m-%d %H:%M:%S") - INFO: $MESSAGE" | tee -a $LOG_FILE
}

# ==============================
# Checks
# ==============================

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE=${CPU_USAGE%.*} # remove decimal
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    log_alert "High CPU usage: ${CPU_USAGE}%"
fi

# Memory Usage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
MEM_USAGE=${MEM_USAGE%.*}
if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
    log_alert "High Memory usage: ${MEM_USAGE}%"
fi

# Disk Usage (/ partition)
DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    log_alert "High Disk usage: ${DISK_USAGE}%"
fi

# Running Processes
PROC_COUNT=$(ps -e --no-headers | wc -l)
if [ "$PROC_COUNT" -gt "$PROC_THRESHOLD" ]; then
    log_alert "Too many processes running: $PROC_COUNT"
fi

# If no issues, log healthy state
if [ "$CPU_USAGE" -le "$CPU_THRESHOLD" ] && \
   [ "$MEM_USAGE" -le "$MEM_THRESHOLD" ] && \
   [ "$DISK_USAGE" -le "$DISK_THRESHOLD" ] && \
   [ "$PROC_COUNT" -le "$PROC_THRESHOLD" ]; then
    log_info "System health is normal. CPU=${CPU_USAGE}%, MEM=${MEM_USAGE}%, DISK=${DISK_USAGE}%, PROC=${PROC_COUNT}"
fi

