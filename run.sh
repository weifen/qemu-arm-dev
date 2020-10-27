#!/bin/sh
[ ! -d "./source" ] && git clone git://git.qemu-project.org/qemu.git && mv ./qemu ./source

[ ! -d "./system" ] && mkdir -p ./system && cd ./system \
 && curl -O  curl -O https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2020-08-24/2020-08-20-raspios-buster-armhf-lite.zip \
 && unzip 2020-08-20-raspios-buster-armhf-lite.zip && rm 2020-08-20-raspios-buster-armhf-lite.zip  && cd ..

[ ! -d "./system/qemu-rpi-kernel" ] && git clone https://github.com/dhruvvyas90/qemu-rpi-kernel.git
 
if [[ "$(docker images -q qemu-raspberry-pi 2> /dev/null)" == "" ]]; then
  docker build -t qemu-raspberry-pi docker
fi


sleep 1

echo 'To start a qemu-raspberry-pi container, run the following command.'
echo 'docker run -it -v $PWD:/qemu qemu-raspberry-pi /bin/bash'


