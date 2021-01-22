cd ..
[ ! -d "system" ] && mkdir -p system
cd system
[ ! -d "os" ] && mkdir -p os
cd os
echo '1. download os images in '$PWD
echo '1.1 Raspbian: 2020-08-20-raspios-buster-armhf-lite.img'
[ ! -e "2020-08-20-raspios-buster-armhf-lite.img" ] \
&& wget -c https://downloads.raspberrypi.org/raspios_lite_armhf/images/raspios_lite_armhf-2020-08-24/2020-08-20-raspios-buster-armhf-lite.zip \
&& unzip 2020-08-20-raspios-buster-armhf-lite.zip && rm 2020-08-20-raspios-buster-armhf-lite.zip
echo '1.2 Linaro Virt: vexpress64-openembedded_lamp-armv8-gcc-4.9_20150620-722.img'
[ ! -e "vexpress64-openembedded_lamp-armv8-gcc-4.9_20150620-722.img" ] \
&& wget -c http://releases.linaro.org/archive/15.06/openembedded/aarch64/vexpress64-openembedded_lamp-armv8-gcc-4.9_20150620-722.img.gz \
&& gzip -d vexpress64-openembedded_lamp-armv8-gcc-4.9_20150620-722.img.gz
cd ..
echo '2. download qemu kernel'
echo '2-1. Raspberry pi in '$PWD'/qemu-rpi-kernel'
[ ! -d "./qemu-rpi-kernel" ] \
&& git clone https://github.com/dhruvvyas90/qemu-rpi-kernel.git
echo '2-2. Linaro in '$PWD'/qemu-linaro-kernel'
[ ! -d "./qemu-linaro-kernel" ] && mkdir -p ./qemu-linaro-kernel && cd qemu-linaro-kernel && wget -c http://releases.linaro.org/archive/15.06/openembedded/aarch64/Image && cd ..
echo '3. build docker image: qemu-arm-ubuntu'
cd ..
if [[ "$(docker images -q qemu-arm-ubuntu 2> /dev/null)" == "" ]]; then
  docker build -t qemu-arm-ubuntu qemu-arm-dev/docker
fi

sleep 1

echo 'all done'

# echo 'To start a qemu-arm-ubuntu container in background, run the following command.'
# echo 'docker run -ti -d -v $PWD:/workspace --name qemu-arm-ubuntu qemu-arm-ubuntu'