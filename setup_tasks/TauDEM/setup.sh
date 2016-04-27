#!/bin/bash

# Setup gdal
tar xvf ../../prework/packages/gdal-2.0.2.tar.xz -C ~
cd ~/gdal-2.0.2/
CC="icc" CFLAGS="-O3 -xHOST -ipo -no-prec-div -no-prec-sqrt" CXX="icpc" CXXFLAGS="${CFLAGS}" ./configure
make -j5
make install
cd -

# Setup TauDEM
tar xvf ../../prework/packages/v5.3.3.tar.gz -C ~
cp ./makefile ~/TauDEM-5.3.3/src/
cd ~/TauDEM-5.3.3/src/
make -j5

