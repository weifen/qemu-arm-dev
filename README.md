# Introduction
This project sets up a docker container for QEMU developers. 
By default, the startup script in the container compiles the QEMU with {arm-softmmu, aarch64-softmmu} in the target list. 
For other targets, you can recompile QEMU in the container.  

# Usage
1. `./run` will
    1. get Raspbian and Linaro OS image.
    2. get qemu kernel for raspi and linaro.
    4. get tutorials git
    3. build docker image: qemu-arm-ubuntu.
2. `./run build` will start a qemu container and build qemu.
3. `./run raspi` will start a qemu container and emulate raspbian.
4. `./run linaro` will start a qemu container and emulate linaro.