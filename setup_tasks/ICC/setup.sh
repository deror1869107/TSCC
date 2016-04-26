#!/bin/sh -ev

ICCVER="parallel_studio_xe_2016_update2"

tar xvf ../../prework/packages/${ICCVER}.tgz
cp license.lic /root/license.lic
cd ${ICCVER}/
sed -e "/ACCEPT_EULA=/ s/decline/accept/" \
    -e "/ACTIVATION_LICENSE_FILE=/ s/$/\/root\/license.lic/" \
    -e "s/#ACTIVATION_LICENSE_FILE/ACTIVATION_LICENSE_FILE/" \
    -e "/ACTIVATION_TYPE=/ s/exist_lic/license_file/" \
    -i".bak" silent.cfg
./install.sh -s silent.cfg
cd ..

echo '----------------------------------------------'
echo ''
echo 'Please enter this command `source ~/.bash_profile`'
echo ''
echo '----------------------------------------------'
