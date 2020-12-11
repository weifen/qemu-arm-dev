#!/bin/bash

./bin/debug/native/qemu-system-aarch64 \
	-m 1024 \
	-cpu cortex-a53 \
	-nographic \
	-machine virt \
	-kernel ../system/Image \
	-append 'root=/dev/vda2 rw rootwait mem=1024M console=ttyAMA0,38400n8' \
	-drive "if=none,id=image,file=../system/vexpress64-openembedded_lamp-armv8-gcc-4.9_20150620-722.img" \
	-netdev "user,id=user0" \
	-device "virtio-net-device,netdev=user0" \
	-device "virtio-blk-device,drive=image" \
	-device "virtio-9p-device,fsdev=r,mount_tag=r" \
	-fsdev "local,id=r,path=/qemu,security_model=none"
