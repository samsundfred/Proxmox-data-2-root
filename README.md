# Proxmox-data-2-root

Merge Empty pve-data into Root on Proxmox VE

Merge all free space from an empty LVM pve-data logical volume into your root partition (pve-root) safely on Proxmox VE.

⚠️ Warning

This script will permanently delete all data on pve-data. Only run it if:

pve-data is empty

Or you have backed up everything on that volume

Do not run on systems where pve-data contains active VMs, containers, or important files.

Features

Deletes the empty pve-data logical volume

Expands pve-root to reclaim all freed space

Resizes the ext4 filesystem

Stops and restarts necessary Proxmox services automatically

Shows updated disk usage after completion

Requirements

Proxmox VE 7.x or later

ext4 root filesystem (pve-root)

LVM volume group named pve

Run as root

Usage

Download or create the script:

nano merge_pve_data.sh
# Paste the script content


Make it executable:

chmod +x merge_pve_data.sh


Run the script as root:

sudo ./merge_pve_data.sh


After completion, your root partition (pve-root) will include all previously allocated pve-data space.

How it Works

Stops Proxmox storage services (pvedaemon, pve-cluster, pve-storage)

Deletes the empty pve-data logical volume

Extends pve-root to occupy all free space in the LVM volume group pve

Resizes the filesystem to use the new space

Restarts Proxmox services

Displays updated disk usage with df -h /

Example Output
=== Stopping Proxmox services ===
=== Removing empty LV /dev/pve/data ===
=== Extending root LV to use all free space ===
=== Resizing root filesystem ===
resize2fs 1.45.6 (20-Mar-2020)
Filesystem at /dev/pve/root is mounted on /; on-line resizing required
old desc_blocks = 2, new_desc_blocks = 3
The filesystem on /dev/pve/root is now 160000 4k blocks long.
=== Restarting Proxmox services ===
=== Done! ===
Filesystem      Size  Used Avail Use% Mounted on
/dev/mapper/pve-root
                160G   6G  150G   4% /

License

MIT License
 – free to use, modify, and distribute.
