#!/bin/bash

# Define the output file location
OUTPUT_FILE="$HOME/Desktop/wifi_debug_report.txt"

# Identify the wireless interface name dynamically
WIFI_IFACE=$(nmcli -t -f DEVICE,TYPE device | grep wifi | cut -d: -f1)

# Initialize the file and clear any previous content
echo "--- WiFi Troubleshooting Report ---" > "$OUTPUT_FILE"
echo "Generated on: $(date)" >> "$OUTPUT_FILE"
echo "Detected Interface: ${WIFI_IFACE:-None}" >> "$OUTPUT_FILE"
echo "-----------------------------------" >> "$OUTPUT_FILE"

echo "Report initialized at $OUTPUT_FILE"

