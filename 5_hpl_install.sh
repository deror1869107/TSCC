. ./0_settings.sh
# hpl (use openblas-icc instead of mkl)
# wget http://www.netlib.org/benchmark/hpl/hpl-2.1.tar.gz
wget $SITE/dkg/hpl-2.2.tar.gz
tar zxf hpl-2.2.tar.gz
cd hpl-2.2/setup
sh make_generic
cp Make.UNKNOWN ../Make.Linux
cd ..
sed -e "/ARCH \+=/ s/UNKNOWN/Linux/" \
    -e "/TOPdir \+=/ s/\$(HOME)\/hpl/\$(HOME)\/hpl-2\.2/" \
    -e "/MPdir \+=/ s/$/ \/opt\/openmpi-icc/" \
    -e "/MPinc \+=/ s/^/#/" \
    -e "/MPlib \+=/ s/$/ \$(MPdir)\/lib\/libmpi.so/" \
    -e "/LAdir \+=/ s/$/ \/opt\/openblas-icc/" \
    -e "/LAlib \+=/ s/-lblas/ \$(LAdir)\/lib\/libopenblas_nehalem-r0\.2\.15\.a/" \
    -e "/CC \+=/ s/mpicc/\/opt\/openmpi-icc\/bin\/mpicc/" \
    -e "/CCFLAGS \+=/ s/$/ -O3/" \
    -e "/LINKER \+=/ s/mpif77/\/opt\/openmpi-icc\/bin\/mpif77/" \
    -e "/LINKFLAGS \+=/ s/$/\$(CCFLAGS) -nofor_main/" \
    -i".bak" Make.Linux
make arch=Linux 
cd ..
