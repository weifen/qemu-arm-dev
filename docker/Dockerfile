FROM ubuntu:18.04

LABEL maintainer "Wei-Fen Lin <weifen@gs.ncku.edu.tw>"

# Location in the container file system where the host gem5 working
# directory is expected to be mounted.
ARG mountdir=/qemu

## Install dependency
RUN apt-get update \
    && apt-get install -y git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev \
       git-email \
       libaio-dev libbluetooth-dev libbrlapi-dev libbz2-dev \
       libcap-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev \
       libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev \
       librbd-dev librdmacm-dev \
       libsasl2-dev libsdl1.2-dev libseccomp-dev libsnappy-dev libssh2-1-dev \
       libvde-dev libvdeplug-dev libvte-dev libxen-dev liblzo2-dev \
       valgrind xfslibs-dev \
       libnfs-dev libiscsi-dev python3 python3-setuptools \
       ninja-build vim emacs

WORKDIR $mountdir
# Watermark $mountdir in docker image, so we can detect if a host directory is
# actualy mounted on top when we run the container.
RUN touch .in-docker-container

ADD startup.sh /
RUN set -x \
    && sed -e s@#MOUNTDIR#@mountdir=$mountdir@ /startup.sh \
       > /usr/local/bin/startup \
    && chmod 755 /usr/local/bin/startup \
    && rm /startup.sh

# Run the front-end script
ENTRYPOINT ["/usr/local/bin/startup"]

