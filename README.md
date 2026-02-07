# Ubuntu WiFi Troubleshooter

A collection of tools to diagnose "Ghost Connections" (connected status with no throughput) on Ubuntu Linux.

## Repository Structure

- `wifi_troubleshoot.md`: Reference guide for manual troubleshooting.
- `collect_wifi_logs.sh`: Automated diagnostic script.
- `reports/`: (Optional) Recommended folder to store generated logs.

## Quick Start

1. Clone the repository.
2. Make the script executable:
   ```bash
   chmod +x collect_wifi_logs.sh
   ```


3. Run the script when a disconnect occurs:
```bash
./collect_wifi_logs.sh
```
