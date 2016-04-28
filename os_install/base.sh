#!/bin/sh -ev

. ./config.sh

# partition
sgdisk -o $DISK1
sgdisk -z $DISK1
sgdisk -n 128:0:+2M		-c 128:"BIOS boot partion"	-t 128:ef02 $DISK1
sgdisk -n 1:0:+200M		-c 1:"Linux RAID /boot"		-t 1:fd00 $DISK1
sgdisk -n 2:0:+16G		-c 2:"Linux swap"			-t 2:8200 $DISK1
sgdisk -n 3:0:0 		-c 3:"Linux / btrfs"		-t 3:8300 $DISK1
sgdisk -p $DISK1

partprobe $DISK1

#format disk
mkfs.ext2 "${DISK1}1"
mkfs.ext4 "${DISK1}3"
mount "${DISK1}3" /mnt/
mkdir /mnt/boot/ && mount "${DISK1}1" /mnt/boot/

# swap
mkswap "${DISK1}2"
swapon "${DISK1}2"


# base system
./bin/pacstrap.in /mnt/ ../prework/pacman/*
./bin/pacstrap.in /mnt/ ../prework/pacman_aur/*

# fstab
genfstab -p /mnt/ | tee /mnt/etc/fstab

cp -r ../ /mnt/root
cp -r /mnt/archiso/bootmnt/parallel*.tgz /mnt/root/prework/packages
