#!/bin/bash

# ==============================
# Automated Backup Script
# ==============================

# Source directory to back up
SOURCE_DIR="/home/ubuntu/mydata"

# Destination directory for backups
BACKUP_DIR="/backups"

# Log file
LOG_FILE="/var/log/backup.log"

# Filename with date and time
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Ensure backup directory exists
mkdir -p $BACKUP_DIR

# Ensure log file exists
touch $LOG_FILE

# Function to log messages
log_message() {
    local STATUS=$1
    local MESSAGE=$2
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $STATUS: $MESSAGE" | tee -a $LOG_FILE
}

# Perform backup
tar -czf $BACKUP_FILE $SOURCE_DIR 2>>$LOG_FILE

# Check if backup succeeded
if [ $? -eq 0 ]; then
    log_message "INFO" "Backup successful: $BACKUP_FILE"
else
    log_message "ERROR" "Backup failed for $SOURCE_DIR"
    exit 1
fi

