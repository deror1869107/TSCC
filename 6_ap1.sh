. ./0_settings.sh

cd ~
mkdir -p OpenFOAM
cd OpenFOAM
# wget "" -O OpenFOAM-2.3.0.tgz
wget $SITE/dkg/OpenFOAM-2.3.0.tgz
wget $SITE/dkg/ThirdParty-2.3.0.tgz
tar -xzf OpenFOAM-2.3.0.tgz 
tar -xzf ThirdParty-2.3.0.tgz
#  gcc
source /opt/rh/devtoolset-1.1/enable

sed -e '384 c \     libDir=/opt/openmpi-gcc/lib' \
    -e '388 c \     export MPI_ARCH_PATH=$libDir' \
    -e '389 c \     _foamAddPath    /opt/openmpi-gcc/bin' \
    -i".bak" \
    OpenFOAM-2.3.0/etc/config/settings.sh

export FOAM_INST_DIR=$HOME/OpenFOAM
source $HOME/OpenFOAM/OpenFOAM-2.3.0/etc/bashrc WM_NCOMPPROCS=$((CORE+1)) WM_MPLIB=SYSTEMOPENMPI
cd $HOME/OpenFOAM/OpenFOAM-2.3.0
./Allwmake > make.log
