. ./0_settings.sh
# openmpi-icc
# wget http://www.open-mpi.org/software/ompi/v1.6/downloads/openmpi-1.6.5.tar.gz
MPI="openmpi-1.10.2"
wget $SITE/dkg/${MPI}.tar.gz
tar zxf ${MPI}.tar.gz
#cp -r openmpi-1.6.5 openmpi-icc-src
#mv    openmpi-1.6.5 openmpi-gcc-src

#cd openmpi-icc-src
cd ${MPI}
./configure --prefix=/opt/openmpi-icc CC=icc CXX=icpc F77=ifort FC=ifort
#./configure --prefix=/opt/openmpi-icc --with-openib CC=icc CXX=icpc F77=ifort FC=ifort # infiniband enabled!!! not tested!!!
make -j $((CORE+1)) > make.log
make install clean > install.log
cd ..

# openmpi-gcc
#yum install -y libibverbs-devel # infiniband enabled!!! not tested!!!
#cd ~/openmpi-gcc-src
cd ${MPI}
./configure --prefix=/opt/openmpi-gcc CC=/opt/rh/devtoolset-1.1/root/usr/bin/gcc CXX=/opt/rh/devtoolset-1.1/root/usr/bin/g++
#./configure --prefix=/opt/openmpi-gcc # infiniband enabled!!! not tested!!!
make -j $((CORE+1)) > make.log
make install clean > install.log
cd ..

# openblas-icc
BLAS="OpenBLAS.v0.2.15"
wget $SITE/dkg/${BLAS}.tar.gz
tar zxf ${BLAS}.tar.gz
cd OpenBLAS-0.2.15
make -j $((CORE+1)) BINARY=64 CC=icc FC=ifort USE_THREAD=0 TARGET=NEHALEM > make.log
make install PREFIX=/opt/openblas-icc > install.log
cd ..

