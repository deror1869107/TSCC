. ./0_settings.sh

wget $SITE/dkg/lammps_stable.tar.gz
tar zxf lammps_stable.tar.gz
cd lammps-1Feb14

cd lib/cuda
sed \
	-e 's/-L\${CUDA_INSTALL_PATH}\/lib //' \
	-i'.bak' Makefile.common
make precision=1 cufft=1 arch=13 -j $((CORE+1)) > make.log
cd ../..

cd src/MAKE
wget $SITE/dkg/Makefile.dkg -O Makefile.dkg
cd ..
make yes-user-cuda
make -j $((CORE+1)) dkg > make.log
cd ..

cd ..

