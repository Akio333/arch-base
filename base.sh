#!/bin/bash

# Setting up vars
read -p 'Hostname: ' hostvar
read -sp 'root password: ' rootpass
echo "Create New User..."
read -p 'Username: ' uservar
read -sp 'Password: ' passvar

echo root:$rootpass | chpasswd

# Localization
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo $hostvar >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostvar.localdomain $hostvar" >> /etc/hosts

# Base Install
pacman -S --noconfirm grub efibootmgr dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb bash-completion openssh rsync reflector dnsmasq vde2 openbsd-netcat ebtables iptables ipset acpid os-prober ntfs-3g terminus-font

# GPU Drivers installation
# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-prime nvidia-utils nvidia-settings 

# Install BootLoader
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Enable essantial services
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable acpid

# Creating User
useradd -m $uservar
echo $uservar:$passvar | chpasswd
usermod -aG libvirt,wheel,audio,video,input,lp,storage,users,network,power $uservar

# Modify sudoers
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers.d/$uservar



