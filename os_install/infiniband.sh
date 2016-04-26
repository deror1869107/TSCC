#!/bin/bash

systemctl enable rdma
systemctl start rdma

if [[ `cat /etc/hostname` == "node1" ]]; then
	systemctl enable opensm
	systemctl start opensm
else
	systemctl disable opensm
	systemctl stop opensm
fi	

NODE_INDEX=`cat /etc/hostname | tail -c 2`
echo "[Match]
Name=ib0

[Network]
Address=10.0.0.${NODE_INDEX}/24
" > /etc/systemd/network/ib0.network

systemctl enable systemd-networkd.service
systemctl restart systemd-networkd.service

echo "* soft memlock unlimited" >> /etc/security/limits.conf
echo "* hard memlock unlimited" >> /etc/security/limits.conf

echo "
###################################################
# Infiniband is set. Please use qperf to test it. #
###################################################"

