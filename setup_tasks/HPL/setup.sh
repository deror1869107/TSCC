#!/bin/sh -ev

# hpl (use icc impi intel-mkl)
mkdir -p ../../tscc/HPL/
cd ../../tscc/HPL/
rm -rf *
cp ../../prework/packages/hpl-2.2.tar.gz .
tar zxf hpl-2.2.tar.gz
cd hpl-2.2/setup
sh make_generic
cp Make.UNKNOWN ../Make.Linux
cd ..
sed -e "/ARCH \+=/ s/UNKNOWN/Linux/" \
    -e "/TOPdir \+=/ s/\$(HOME)\/hpl/""$(sed 's/\//\\\//g' <<< ${PWD})""/" \
    -e "/MPdir \+=/ s/$/ \/opt\/intel\/impi\/5.1.3.181\/intel64/" \
    -e "/MPinc \+=/ s/^/\$(MPdir)\/include64/" \
    -e "/MPlib \+=/ s/$/\$(MPdir)\/lib\/libmpi.so/" \
    -e "/LAdir \+=/ s/$/\/opt\/intel\/mkl\/lib\/intel64/" \
    -e "/LAinc \+=/ s/$/-I\/opt\/intel\/compilers_and_libraries_2016\/linux\/mkl\/include/" \
    -e "/LAlib \+=/ s/-lblas/ -mkl=cluster/" \
    -e "/CC \+=/ s/mpicc/mpiicc/" \
    -e "/CCFLAGS \+=/ s/$/ -openmp -xHost -fomit-frame-pointer -O3 -funroll-loops $(HPL_DEFS)/" \
    -e "/LINKER \+=/ s/mpif77/mpiicc/" \
    -e "/LINKFLAGS \+=/ s/$/\$(CCFLAGS)/" \
    -i".bak" Make.Linux
make arch=Linux 
