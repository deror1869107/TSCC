#!/bin/bash

# rsh
systemctl enable xinetd.service
sed -i '/disable/ s/yes/no/' /etc/xinetd.d/rsh
systemctl restart xinetd.service

if [[ -z `cat /etc/securetty | grep rsh` ]]; then
        echo "rsh" >> /etc/securetty
fi

echo "10.0.0.1
10.0.0.2
10.0.0.3
10.0.0.4" > /root/.rhosts

echo "##### RSH is set #####"

# ssh (Only node1 can access all node2 without passwords)
echo "PermitRootLogin Yes" >> /etc/ssh/sshd_config
systemctl enable sshd.service


if [[ `cat /etc/hostname` == "node1" ]]; then
        echo "##### Please enter through the keygen process #####"
        ssh-keygen
        echo "##### Please key in password for 4 times #####"
        ssh-copy-id -i ~/.ssh/id_rsa.pub root@node1
        ssh-copy-id -i ~/.ssh/id_rsa.pub root@node2
        ssh-copy-id -i ~/.ssh/id_rsa.pub root@node3
        ssh-copy-id -i ~/.ssh/id_rsa.pub root@node4
else
        echo "##### This machine is not node1, right? #####"
fi

systemctl restart sshd.service

echo "##### SSH is set #####"

