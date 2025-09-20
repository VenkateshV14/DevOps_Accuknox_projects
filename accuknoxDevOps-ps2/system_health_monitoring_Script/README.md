# System Health Monitoring Script

## Overview
This script monitors the health of a Linux system. It checks:
- CPU usage
- Memory usage
- Disk space
- Running processes

If any of these exceed predefined thresholds, it logs an **ALERT** and prints it to the console. Otherwise, it logs that the system is healthy.

---

## Requirements
- Linux environment (tested on Ubuntu EC2)
- Basic commands available: `top`, `free`, `df`, `ps`

---

## Usage
1. Make the script executable:
   ```bash
   chmod +x system_health.sh
2. Run it:
   ./system_health.sh
3. Logs will be saved in:
   ~/system_health.log
