# Automated Backup Script

## Overview
This script automates the backup of a specified directory by compressing it into a `.tar.gz` file.  
Each backup is timestamped and stored in a backup folder.  
It logs whether the backup was successful or failed.

---

## Requirements
- Linux environment (tested on Ubuntu EC2)
- `tar` command installed

---

## Usage
1. Set source and destination directories:
   ```bash
   SOURCE_DIR="/home/ubuntu/mydata"
   BACKUP_DIR="/home/ubuntu/backups"
   LOG_FILE="/home/ubuntu/backup.log"
2. Make the script executable:
   chmod +x backup.sh
3. Run it:
   ./backup.sh
4. Logs will be saved in:
   ~/backup.log
