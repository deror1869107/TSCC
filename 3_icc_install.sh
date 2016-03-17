#!/bin/sh -x
. ./0_settings.sh
# intel c compiler (icc) & intel mkl
ICCPKG="parallel_studio_xe_2016_update2"
if [ ! -e "${ICCPKG}.tgz" ] ; then
	wget $SITE/dkg/parallel_studio_xe_2016_update2.tgz
fi 
if [ ! -e $ICCPKG ] ; then
	tar zxf parallel_studio_xe_2016_update2.tgz
fi 
cd  parallel_studio_xe_2016_update2
sed -e "/ACCEPT_EULA=/ s/decline/accept/" \
    -e "/ACTIVATION_LICENSE_FILE=/ s/$/\/root\/license.lic/" \
    -e "s/#ACTIVATION_LICENSE_FILE/ACTIVATION_LICENSE_FILE/" \
    -e "/ACTIVATION_TYPE=/ s/exist_lic/license_file/" \
    -i".bak" silent.cfg
./install.sh -s silent.cfg
cd ..

exit
# intel fortran (ifort)
wget $SITE/dkg/l_fcompxe_2013_sp1.2.144.tgz
tar zxf l_fcompxe_2013_sp1.2.144.tgz
cd l_fcompxe_2013_sp1.2.144
sed -e "/ACCEPT_EULA=/ s/decline/accept/" \
    -e "/ACTIVATION_LICENSE_FILE=/ s/$/\/root\/license.lic/" \
    -e "s/#ACTIVATION_LICENSE_FILE/ACTIVATION_LICENSE_FILE/" \
    -e "/ACTIVATION_TYPE=/ s/exist_lic/license_file/" \
    -i".bak" silent.cfg
./install.sh -s silent.cfg
cd ..
