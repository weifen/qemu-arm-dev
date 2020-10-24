#!/bin/sh
[ ! -d "./source" ] && git clone git://git.qemu-project.org/qemu.git && mv ./qemu ./source

if [[ "$(docker images -q qemu-arm-dev 2> /dev/null)" == "" ]]; then
  docker build -t qemu-arm-dev docker
fi


sleep 1

echo 'To start a qemu-arm-dev container, run the following command.'
echo 'docker run -it -v $PWD:/qemu qemu-arm-dev /bin/bash'


