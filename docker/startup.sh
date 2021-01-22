#!/bin/bash

#MOUNTDIR#  # substituted during docker build
mountdir=${mountdir:-'/qemu'}

echo $1
echo ${mountdir}
## build QEMU in $mountdir

# cd ${mountdir}/source || exit 1
# mkdir -p bin/debug/native || exit 1
# cd bin/debug/native || exit 1
# ../../../configure --enable-debug  --target-list=arm-softmmu,aarch64-softmmu --enable-virtfs || exit 1
# make -j $(nproc) || exit 1
# cd ../../.. || exit 1

exec /bin/bash -l