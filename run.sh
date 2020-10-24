#!/bin/sh
[ ! -d "./source" ] && git clone git://git.qemu-project.org/qemu.git && mv ./qemu ./source

[ ! -d "./system" ] && mkdir -p ./system && cd ./system \
 && curl -O  https://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2020-02-14/2020-02-13-raspbian-buster-lite.zip \
 && unzip 2020-02-13-raspbian-buster-lite.zip && 2020-02-13-raspbian-buster-lite.zip  && cd ..

[ ! -d "./system/qemu-rpi-kernel" ] && git clone https://github.com/dhruvvyas90/qemu-rpi-kernel.git
 
if [[ "$(docker images -q qemu-raspberry-pi 2> /dev/null)" == "" ]]; then
  docker build -t qemu-raspberry-pi docker
fi


sleep 1

echo 'To start a qemu-raspberry-pi container, run the following command.'
echo 'docker run -it -v $PWD:/qemu qemu-raspberry-pi /bin/bash'


