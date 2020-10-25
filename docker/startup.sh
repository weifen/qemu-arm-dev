#!/bin/bash

#MOUNTDIR#  # substituted during docker build
# mountdir=${mountdir:-'/qemu'}

## build QEMU in $mountdir

# cd ${mountdir}/source || exit 1
# mkdir -p bin/debug/native || exit 1
# cd bin/debug/native || exit 1
# ../../../configure --enable-debug  --target-list=arm-softmmu,aarch64-softmmu || exit 1
# make -j $(nproc) || exit 1
# cd ../../.. || exit 1

# exec /bin/bash -l
image_path="/root/qemu-rpi-image/raspbian.img"
emulator=/qemu/bin/debug/native/qemu-system-arm
kernel="/root/qemu-rpi-kernel/kernel-qemu-4.19.50-buster"
dtb="/root/qemu-rpi-kernel/versatile-pb.dtb"
machine=versatilepb
memory=256m
root=/dev/sda2
nic='--net nic --net user,hostfwd=tcp::5022-:22'

echo "Booting QEMU machine \"${machine}\" with kernel=${kernel} dtb=${dtb}"
exec ${emulator} \
  --machine "${machine}" \
  --cpu arm1176 \
  --m "${memory}" \
  --drive "format=raw,file=${image_path}" \
  ${nic} \
  --dtb "${dtb}" \
  --kernel "${kernel}" \
  --append "rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=${root} rootwait panic=1" \
  --no-reboot \
  --display none \
  --serial mon:stdio
