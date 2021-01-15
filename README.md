
  This project sets up a docker container for QEMU developers. 
  By default, the startup script in the container compiles the QEMU with {arm-softmmu, aarch64-softmmu} in the target list. 
  For other targets, you can recompile QEMU in the container.  

1. 在MACOSX 11.1 使用vistual studio code開發缺乏套件
2. 每次Docker Run都會執行startup.sh去做config跟make要花一點時間，寫完code都要等待，有沒有更好的方式
