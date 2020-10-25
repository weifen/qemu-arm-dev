#!/bin/sh
[ ! -d "./docker/source" ] && git clone git://git.qemu-project.org/qemu.git && mv ./qemu ./docker/source
# if [[ "$(docker images -q qemu-raspi 2> /dev/null)" == "" ]]; then
  docker build -t qemu-raspi docker
# fi

sleep 1

echo 'To start a qemu-raspi container, run the following command.'
echo 'docker run -it -v qemu-raspi /bin/bash'