# arch-base

If needed, load your keymap
Refresh the servers with pacman -Syy
Partition the disk
Format the partitions
Mount the partitions
Install the base packages into /mnt (pacstrap /mnt base linux linux-firmware git vim intel-ucode (or amd-ucode))
Generate the FSTAB file with genfstab -U /mnt >> /mnt/etc/fstab
Chroot in with arch-chroot /mnt
Download the git recpository with git clone https://github.com/Akio333/arch-install.git

cd arch-install
chmod +x base.sh
run with ./base.sh
