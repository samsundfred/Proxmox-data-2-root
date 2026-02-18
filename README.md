# Proxmox-data-2-root

Merge Empty pve-data into Root on Proxmox VE

Safely deletes an empty LVM pve-data logical volume and merges its space into the root partition (pve-root) on Proxmox VE.

⚠️ Warning

All data in pve-data will be permanently deleted.

Only run if pve-data is empty or fully backed up.

Do not run on systems with active VMs or containers in pve-data.

Features

Deletes empty pve-data LV

Expands pve-root to reclaim all freed space

Resizes the ext4 filesystem

Stops and restarts Proxmox services automatically

Shows updated disk usage after completion

Requirements

Proxmox VE 7.x+

ext4 root filesystem (pve-root)

LVM volume group named pve

Run as root

Quick Install & Run

One-liner to download and execute the script safely:

curl -sSL https://raw.githubusercontent.com/samsundfred/Proxmox-data-2-root/main/merge_pve_data.sh | sudo bash


Replace YourUsername/proxmox-scripts with your GitHub repo path.

Manual Installation

Create the script file:

nano merge_pve_data.sh
# Paste the script content


Make it executable:

chmod +x merge_pve_data.sh


Run it as root:

sudo ./merge_pve_data.sh

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

How it Works

Stops Proxmox services (pvedaemon, pve-cluster, pve-storage)

Deletes the empty pve-data LV

Extends pve-root to use all free space in LVM

Resizes the root filesystem (resize2fs)

Restarts Proxmox services

Shows updated disk usage

License

MIT License – free to use, modify, and distribute.
