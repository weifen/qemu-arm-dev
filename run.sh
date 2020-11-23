#!/bin/sh
[ ! -d "./source" ] && git clone git://git.qemu-project.org/qemu.git && mv ./qemu ./source

[ ! -d "./system" ] && mkdir -p ./system && cd ./system \
 && curl -O  curl -O https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2020-08-24/2020-08-20-raspios-buster-armhf-lite.zip \
 && unzip 2020-08-20-raspios-buster-armhf-lite.zip && rm 2020-08-20-raspios-buster-armhf-lite.zip  && cd ..

[ ! -d "./system/qemu-rpi-kernel" ] && cd ./system && git clone https://github.com/dhruvvyas90/qemu-rpi-kernel.git && cd ..

[ ! -e "./system/Image" ] && wget http://releases.linaro.org/archive/15.06/openembedded/aarch64/Image 
[ ! -e "./system/vexpress64-openembedded_lamp-armv8-gcc-4.9_20150620-722.img" ] && wget http://releases.linaro.org/archive/15.06/openembedded/aarch64/vexpress64-openembedded_lamp-armv8-gcc-4.9_20150620-722.img.gz && gzip -d ./system/vexpress64-openembedded_lamp-armv8-gcc-4.9_20150620-722.img.gz
 
if [[ "$(docker images -q qemu-linaro-virt 2> /dev/null)" == "" ]]; then
  docker build -t qemu-linaro-virt docker
fi


sleep 1

echo 'To start a qemu-linaro-virt container, run the following command.'
echo 'docker run -it --privileged -v $PWD:/qemu qemu-linaro-virt /bin/bash'


