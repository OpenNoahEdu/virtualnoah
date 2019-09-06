#!/bin/sh

# Build cross tools
cd crosstools
./build-mips-cross-tools-no-glibc.sh
export PATH=$PATH:~/opt/mipseltools-gcc412/bin/
cd ..

# Build unpkg
make -C ./unpkg/src

# Download upgrade.bin and run unpkg
mkdir upgrade
cd upgrade
wget http://files.noahedu.com/upload/Tools/2008/51week/NP1100%E5%8D%87%E7%BA%A7%E7%A8%8B%E5%BA%8FV3.3.73.rar
unrar x NP1100升级程序V3.3.73.rar
../unpkg/src/unpkg upgrade.bin
cd ..

# Build qemu-jz
cd qemu-JZ
./configure --target-list=mipsel-softmmu
make CFLAGS="-w"
cd ..

# Build mknandflash
make -C ./np_tools/mknandflash

cd u-boot
make pavo_nand_config
make
cd ..

cd linux
make pavo_defconfig
make uImage
cd ..
