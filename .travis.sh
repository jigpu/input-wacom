#!/bin/sh

set -e -x

CONFIG_FLAGS="--with-kernel=${KERNELDIR}/${KERNEL}"
EXTRA_CFLAGS="-Werror -Wno-type-limits -Wno-unused-function -isystem ${KERNELDIR}/${KERNEL}/arch/x86/include -isystem ${KERNELDIR}/${KERNEL}/arch/x86/include/uapi -isystem ${KERNELDIR}/${KERNEL}/include/linux"

# Try a developer build
./autogen.sh $CONFIG_FLAGS
make EXTRA_CFLAGS="$EXTRA_CFLAGS"
sudo make install
#sudo make uninstall
#make clean

# Try to create and build a source tarball
make dist
tar xvfj *.bz2
rm *.bz2
cd input-wacom-*
./configure $CONFIG_FLAGS
make EXTRA_CFLAGS="$EXTRA_CFLAGS"
sudo make install
#sudo make uninstall
#make clean