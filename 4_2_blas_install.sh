. ./0_settings.sh
# openblas-icc
BLAS="OpenBLAS.v0.2.15"
wget $SITE/dkg/${BLAS}.tar.gz
tar zxf ${BLAS}.tar.gz
cd OpenBLAS-0.2.15
make BINARY=64 CC=icc FC=ifort USE_THREAD=0 TARGET=NEHALEM 
make PREFIX=/opt/openblas-icc install
cd ..

