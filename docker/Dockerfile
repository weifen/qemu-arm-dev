FROM ubuntu:20.04

LABEL maintainer "Wei-Fen Lin <weifen@gs.ncku.edu.tw>"

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Location in the container file system where the host gem5 working
# directory is expected to be mounted.
ARG mountdir=/qemu

## Install dependency
RUN set -x \
    && apt-get update \
    && apt-get install -y \
       build-essential git m4 scons zlib1g  zlib1g-dev \
       libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev \
       python-dev python-six doxygen libboost-all-dev pkg-config\
       libhdf5-serial-dev python3-pydot libpng-dev libelf-dev \
       libglib2.0-dev binutils-dev libboost-all-dev autoconf libtool libssl-dev libpixman-1-dev \
       telnet wget python3-pip libcap-dev libcap-ng-dev libattr1-dev \
       ninja-build vim emacs netplan.io

RUN echo "ENABLED=1" | tee /etc/default/netplan

## Install GNU GCC cross compiler for AARCH64
RUN echo 'deb http://archive.ubuntu.com/ubuntu/ focal-proposed universe' >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y gcc-10-aarch64-linux-gnu

WORKDIR $mountdir
# Watermark $mountdir in docker image, so we can detect if a host directory is
# actualy mounted on top when we run the container.
RUN touch .in-docker-container

ENV M5_PATH $mountdir/system

#Full system runs expose console at port 3456. Use telnet or nc on MacOS
EXPOSE 3456/tcp

ADD startup.sh /
RUN set -x \
    && sed -e s@#MOUNTDIR#@mountdir=$mountdir@ /startup.sh \
       > /usr/local/bin/startup \
    && chmod 755 /usr/local/bin/startup \
    && rm /startup.sh

# Run the front-end script
ENTRYPOINT ["/usr/local/bin/startup"]