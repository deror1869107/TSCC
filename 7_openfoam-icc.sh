. ./0_settings.sh
cd ~
mkdir -p OpenFOAM-icc
cd OpenFOAM-icc
wget $SITE/dkg/OpenFOAM-2.3.0.tgz
wget $SITE/dkg/ThirdParty-2.3.0.tgz
tar -xzf OpenFOAM-2.3.0.tgz 
tar -xzf ThirdParty-2.3.0.tgz

sed -e '384 c \     libDir=/opt/openmpi-icc/lib' \
    -e '388 c \     export MPI_ARCH_PATH=$libDir' \
    -e '389 c \     _foamAddPath    /opt/openmpi-icc/bin' \
    -e "89 c \            export WM_CC=\'icc\'" \
    -e "90 c \            export WM_CXX=\'icpc\'" \
    -e "91 c \            export WM_CFLAGS=\'-mmic -m64 -fPIC\'" \
    -e "92 c \            export WM_CXXFLAGS=\'-mmic -m64 -fPIC\'" \
    -e "93 c \            export WM_LDFLAGS=\'-mmic -m64\'" \
    -i".bak" \
	OpenFOAM-2.3.0/etc/config/settings.sh

sed -e '132 c \     export WM_PROJECT_USER_DIR=$WM_PROJECT_INST_DIR/$USER-$WM_PROJECT_VERSION' \
    -i".bak" \
    OpenFOAM-2.3.0/etc/bashrc

export FOAM_INST_DIR=$HOME/OpenFOAM-icc
source $HOME/OpenFOAM-icc/OpenFOAM-2.3.0/etc/bashrc WM_NCOMPPROCS=$((CORE+1)) WM_MPLIB=SYSTEMOPENMPI WM_COMPILER=Icc

cd /root/OpenFOAM-icc/OpenFOAM-2.3.0
./Allwmake > make.log

