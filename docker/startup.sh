#!/bin/bash

#MOUNTDIR#  # substituted during docker build
mountdir=${mountdir:-'/qemu'}

state=$1

cd ${mountdir}

if [ $state == 'build' ]
then
  echo 'build QEMU in '$mountdir
  mkdir -p bin || exit 1
  cd bin || exit 1
  ../tutorials/configure --enable-debug  --target-list=arm-softmmu,aarch64-softmmu --enable-virtfs || exit 1
  make -j $(nproc) || exit 1 
fi

if [ $state == 'raspi' ]
then
  echo 'emulate raspbian'
  bin/qemu-system-arm \
	-M versatilepb \
	-cpu arm1176 \
	-m 1024 \
	-drive "file=system/os/2020-08-20-raspios-buster-armhf-lite.img,if=none,index=0,media=disk,format=raw,id=disk0" \ 
	-device "virtio-blk-pci,drive=disk0,disable-modern=on,disable-legacy=off" \
	-net nic,model=virtio \
	-net user,hostfwd=tcp::5022-:22 \
	-dtb system/qemu-rpi-kernel/versatile-pb-buster-5.4.51.dtb \
	-kernel system/qemu-rpi-kernel/kernel-qemu-5.4.51-buster \
	-append 'root=/dev/vda2 panic=1'  -no-reboot  -nographic
fi

if [ $state == 'linaro' ]
then
  echo 'emulate linaro'
  bin/qemu-system-aarch64 \
	-m 1024 \
	-cpu cortex-a53 \
	-nographic \
	-machine virt \
	-kernel system/qemu-linaro-kernel/Image \
	-append 'root=/dev/vda2 rw rootwait mem=1024M console=ttyAMA0,38400n8' \
	-drive "if=none,id=image,file=system/os/vexpress64-openembedded_lamp-armv8-gcc-4.9_20150620-722.img" \
	-netdev "user,id=user0" \
	-device "virtio-net-device,netdev=user0" \
	-device "virtio-blk-device,drive=image" \
	-device "virtio-9p-device,fsdev=r,mount_tag=r" \
	-fsdev "local,id=r,path=/qemu,security_model=none"
fi

exec /bin/bash -l