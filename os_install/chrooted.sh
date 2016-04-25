#!/bin/sh -ev

. ./config.sh

# hostname
echo $HOSTNAME > /etc/hostname
cat <<EOT >> /etc/hosts
127.0.0.1   localhost
10.0.0.1    node1
10.0.0.2    node2
10.0.0.3    node3
10.0.0.4    node4
EOT

# keymap & locale
echo "KEYMAP=us" > /etc/vconsole.conf

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_CN GB2312" >> /etc/locale.gen
echo "zh_TW.UTF-8 UTF-8" >> /etc/locale.gen
echo "zh_TW BIG5" >> /etc/locale.gen

locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# netctl
echo "Description='A basic static ethernet connection'
Interface=$IF
Connection=ethernet
IP=static
Address=('$IP/24')
#Routes=('192.168.0.0/24 via 192.168.1.2')
Gateway='$GATEWAY'
DNS=('140.113.235.1' '8.8.8.8')
DNSSearch='cs.nctu.edu.tw'
## For IPv6 autoconfiguration
#IP6=stateless
" >> /etc/netctl/ethernet

netctl enable ethernet

# initramfs
mkinitcpio -p linux

# grub
grub-install --target=i386-pc --recheck ${DISK1}
cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

grub-mkconfig -o /boot/grub/grub.cfg

# passwd
passwd
