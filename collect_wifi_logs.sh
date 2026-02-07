#!/bin/bash

# Define the output file location
# This saves the report to a 'reports' folder in the current directory with a timestamp
mkdir -p ./reports
OUTPUT_FILE="./reports/wifi_debug_report_$(date +%Y%m%d_%H%M%S).txt"

# Identify the wireless interface name dynamically
WIFI_IFACE=$(nmcli -t -f DEVICE,TYPE device | grep wifi | cut -d: -f1)

# 1. Initialize the file
echo "--- WiFi Troubleshooting Report ---" > "$OUTPUT_FILE"
echo "Generated on: $(date)" >> "$OUTPUT_FILE"
echo "Detected Interface: ${WIFI_IFACE:-None}" >> "$OUTPUT_FILE"
echo "-----------------------------------" >> "$OUTPUT_FILE"

# 2. Append Network Configuration
echo -e "\n--- Network Configuration ---" >> "$OUTPUT_FILE"
if [ -n "$WIFI_IFACE" ]; then
    ip addr show "$WIFI_IFACE" >> "$OUTPUT_FILE" 2>&1
else
    echo "No WiFi interface detected." >> "$OUTPUT_FILE"
fi

# 3. Append Routing Table
echo -e "\n--- Routing Table ---" >> "$OUTPUT_FILE"
ip route show >> "$OUTPUT_FILE"

# 4. Connectivity Test
echo -e "\n--- Connectivity Test ---" >> "$OUTPUT_FILE"
# Attempt to find the default gateway
GATEWAY=$(ip route | grep default | awk '{print $3}' | head -n 1)

if [ -n "$GATEWAY" ]; then
    ping -c 1 "$GATEWAY" > /dev/null 2>&1 && echo "Gateway ($GATEWAY): Reachable" >> "$OUTPUT_FILE" || echo "Gateway ($GATEWAY): UNREACHABLE" >> "$OUTPUT_FILE"
else
    echo "Gateway: No default route found" >> "$OUTPUT_FILE"
fi

# Test raw internet access (Google DNS)
ping -c 1 8.8.8.8 > /dev/null 2>&1 && echo "Internet (IP 8.8.8.8): Reachable" >> "$OUTPUT_FILE" || echo "Internet (IP): UNREACHABLE" >> "$OUTPUT_FILE"

# Test DNS resolution
ping -c 1 google.com > /dev/null 2>&1 && echo "Internet (DNS google.com): Reachable" >> "$OUTPUT_FILE" || echo "Internet (DNS): UNREACHABLE" >> "$OUTPUT_FILE"

# 5. Hardware Identification
echo -e "\n--- Hardware Identification ---" >> "$OUTPUT_FILE"
if command -v lspci &> /dev/null; then
    lspci -nnk | grep -i net -A2 >> "$OUTPUT_FILE"
else
    echo "Error: lspci command not found." >> "$OUTPUT_FILE"
fi

echo "Report generated: $OUTPUT_FILE"

# 6. RF Kill Status (Hardware/Software Blocks)
echo -e "\n--- RF Kill Status ---" >> "$OUTPUT_FILE"
if command -v rfkill &> /dev/null; then
    rfkill list all >> "$OUTPUT_FILE"
else
    echo "Error: rfkill command not found." >> "$OUTPUT_FILE"
fi
