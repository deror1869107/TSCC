. ./0_settings.sh
# setting files
mkdir -p ~/.ssh/
cd ~/.ssh/
wget $SITE/dkg/id_rsa -O id_rsa
chmod 400 id_rsa
wget $SITE/dkg/id_rsa.pub -O id_rsa.pub
wget $SITE/dkg/authorized_keys -O authorized_keys
cd ~
wget $SITE/dkg/.bashrc -O .bashrc
wget $SITE/dkg/.vimrc -O .vimrc
wget $SITE/license.lic -O license.lic

cat >> /etc/hosts << EOF
127.0.0.1       node1
10.0.0.1        node1
10.0.0.2        node2
10.0.0.3        node3
10.0.0.4        node4
EOF

# shutdown services
chkconfig iptables off
chkconfig ip6tables off
chkconfig postfix off
# Disable selinux
sed -i 's/enforcing/disabled/g' /etc/selinux/config
cat >> /etc/security/limits.conf <<EOF
* soft memlock unlimited
* hard memlock unlimited
EOF

sed \
	-e '/mirrorlist/d' \
	-e "s/http:\/\/mirror.centos.org/http:\/\/$URL/" \
	-e 's/#baseurl/baseurl/' \
	-i'.bak' /etc/yum.repos.d/CentOS-Base.repo
yum-config-manager --nogpgcheck --add-repo $SITE/puias/DevToolset/6.5/x86_64
yum-config-manager --nogpgcheck --add-repo $SITE/atrpms

yum clean all
yum update -y --nogpgcheck
yum groupinstall -y --nogpgcheck "Development Tools"
yum install -y --nogpgcheck vim zlib-devel procmail \
	devtoolset-1.1-runtime devtoolset-1.1-gcc.x86_64 devtoolset-1.1-gcc-c++.x86_64 \
	qtwebkit qtwebkit-devel CGAL CGAL-devel

ln -s /usr/lib64/libboost_thread-mt.so /usr/lib64/libboost_thread.so

cat >> /etc/ld.so.conf <<EOF
/usr/lib64
/opt/intel/lib/intel64
/usr/local/cuda-6.0/lib64
/opt/intel/composer_xe_2013_sp1.2.144/compiler/lib/intel64
/opt/intel/mkl/lib/intel64
EOF
ldconfig

sed -e '/vmlinuz-2.6.32-431.11.2.el6.x86_64/ s/$/ rdblacklist=nouveau nouveau.modeset=0/' /boot/grub/grub.conf

updatedb
echo '---------------------------------------------------------'
echo
echo 'You need to reboot.'
echo
echo '---------------------------------------------------------'
