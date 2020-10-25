# Build stage for qemu-system-arm
FROM ubuntu:18.04 AS qemu-builder
LABEL maintainer "Gimme <P7709122@gs.ncku.edu.tw>"

#Step 2 : setup a QEMU container using Dockerfile
RUN apt-get update && \
	apt-get install -y git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev \
	git-email \
	libaio-dev libbluetooth-dev libbrlapi-dev libbz2-dev \
	libcap-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev \
	libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev \
	librbd-dev librdmacm-dev \
	libsasl2-dev libsdl1.2-dev libseccomp-dev libsnappy-dev libssh2-1-dev \
	libvde-dev libvdeplug-dev libvte-dev libxen-dev liblzo2-dev \
	valgrind xfslibs-dev \
	libnfs-dev libiscsi-dev python3 python3-setuptools \
	ninja-build
COPY source /qemu
RUN cd /qemu \
	&& mkdir -p bin/debug/native \
	&& cd bin/debug/native \
	&& ../../../configure --enable-debug  --target-list=arm-softmmu,aarch64-softmmu \
	&& make -j $(nproc) 

RUN apt-get install -y unzip
# Step 3-1 : Get raspbian image
ARG FILESYSTEM_IMAGE_URL="http://downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2019-09-30/2019-09-26-raspbian-buster-lite.zip"
ARG FILESYSTEM_IMAGE_CHECKSUM="a50237c2f718bd8d806b96df5b9d2174ce8b789eda1f03434ed2213bbca6c6ff"

ADD $FILESYSTEM_IMAGE_URL /tmp/filesystem.zip

RUN cd /tmp && \
    echo "$FILESYSTEM_IMAGE_CHECKSUM  filesystem.zip" | sha256sum -c && \
    unzip filesystem.zip && \
    mkdir -p /root/qemu-rpi-image && \
    cp *.img /root/qemu-rpi-image/raspbian.img && \
    rm -rf /tmp/* 

# Step 3-2 : Get raspi kernel
ARG RPI_KERNEL_URL="https://github.com/dhruvvyas90/qemu-rpi-kernel/archive/afe411f2c9b04730bcc6b2168cdc9adca224227c.zip"
ARG RPI_KERNEL_CHECKSUM="295a22f1cd49ab51b9e7192103ee7c917624b063cc5ca2e11434164638aad5f4"

ADD $RPI_KERNEL_URL /tmp/qemu-rpi-kernel.zip

RUN cd /tmp && \
    echo "$RPI_KERNEL_CHECKSUM  qemu-rpi-kernel.zip" | sha256sum -c && \
    unzip qemu-rpi-kernel.zip && \
    mkdir -p /root/qemu-rpi-kernel && \
    cp qemu-rpi-kernel-*/kernel-qemu-4.19.50-buster /root/qemu-rpi-kernel/ && \
    cp qemu-rpi-kernel-*/versatile-pb.dtb /root/qemu-rpi-kernel/ && \
    rm -rf /tmp/*

ADD startup.sh /usr/local/bin/startup

RUN chmod 755 /usr/local/bin/startup

ENTRYPOINT ["/usr/local/bin/startup"]
