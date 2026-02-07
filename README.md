# Ubuntu WiFi Troubleshooter

Tools to diagnose and fix "Ghost Connections" (connected status, no throughput) on Ubuntu Linux.

## Roadmap

### Phase 1: The Observer (Current)
**Goal:** Capture system state at the moment of failure.
- `collect_wifi_logs.sh`: Generates timestamped reports.
- **Checks:** IP/Route, Connectivity (Ping), Hardware ID, Driver Status, Kernel Logs.

### Phase 2: The Operator (Planned)
**Goal:** Safely reset the network stack without rebooting.
- `reset_wifi.sh`:
  - **Level 1:** Service restart (NetworkManager).
  - **Level 2:** Driver reload (modprobe).
  - **Level 3:** Hardware toggle (rfkill).

### Phase 3: The Analyst (Planned)
**Goal:** Background monitoring and auto-recovery based on heuristics.

## Usage

1. **Make executable:**
   `chmod +x collect_wifi_logs.sh`

2. **Run during a disconnect:**
   `./collect_wifi_logs.sh`

3. **View Report:** Check the `reports/` folder.