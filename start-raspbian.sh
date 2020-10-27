#!/bin/bash

./bin/debug/native/qemu-system-arm  -M versatilepb  -cpu arm1176  -m 256  -hda ../system/2020-08-20-raspios-buster-armhf-lite.img  -net nic,  -net user,hostfwd=tcp::5022-:22  -dtb ../system/qemu-rpi-kernel/versatile-pb-buster-5.4.51.dtb  -kernel ../system/qemu-rpi-kernel/kernel-qemu-5.4.51-buster  -append 'root=/dev/sda2 panic=1'  -no-reboot  -nographic

