# Introduction
This project sets up a docker container for QEMU developers. 
By default, the startup script in the container compiles the QEMU with {arm-softmmu, aarch64-softmmu} in the target list. 
For other targets, you can recompile QEMU in the container.  

# Prepare
Execute `run.sh`
1. get Raspbian and Linaro OS image.
2. get qemu kernel for raspi and linaro.
4. get tutorials git
3. build docker image: qemu-arm-ubuntu.
