#!/bin/bash
# merge_pve_data.sh
# Deletes empty pve-data LV and merges its space into pve-root on Proxmox VE
# Author: Me
# License: MIT

set -euo pipefail

echo "=== Stopping Proxmox services ==="
systemctl stop pvedaemon
systemctl stop pve-cluster
systemctl stop pve-storage

echo "=== Removing empty LV /dev/pve/data ==="
lvremove -f /dev/pve/data

echo "=== Extending root LV to use all free space ==="
lvextend -l +100%FREE /dev/pve/root

echo "=== Resizing root filesystem ==="
resize2fs /dev/pve/root

echo "=== Restarting Proxmox services ==="
systemctl start pve-storage
systemctl start pve-cluster
systemctl start pvedaemon

echo "=== Done! ==="
df -h /
