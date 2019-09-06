#!/bin/sh

# Build qemu-jz
cd qemu-JZ
./configure --target-list=mipsel-softmmu
make CFLAGS="-w"
cd ..

# Build cross tools
cd crosstools
./build-mips-cross-tools-no-glibc.sh
export PATH=$PATH:~/opt/mipseltools-gcc412/bin/
cd ..

# Build u-boot
cd u-boot
make pavo_nand_config
make
cd ..

# Build Kernel
cd linux
make pavo_defconfig
make uImage
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

# Build mknandflash
make -C ./np_tools/mknandflash

# Make np1100.bin
./np_tools/mknandflash/mknandflash np1100.bin \
--uboot \
	u-boot/u-boot-nand.bin \
	0x00000000 \
	0x00200000 \
	0 \
--serial \
	assets/serial.img \
	0x00200000 \
	0x00400000 \
	0 \
--uimage \
	linux/arch/mips/boot/uImage \
	0x00400000 \
	0x00600000 \
	0 \
--rootfs \
	upgrade/rootfs.yaffs2 \
	0x00600000 \
	0x01800000 \
	1 \
	0 \
--settings \
	upgrade/Settings.yaffs2 \
	0x01800000 \
	0x02300000 \
	1 \
	0 \
--progfs \
	upgrade/ProgFS.yaffs2 \
	0x02300000 \
	0x0cd00000 \
	1 \
	0 \
--datafs \
	upgrade/DataFS.yaffs2 \
	0x0cd00000 \
	0x15900000 \
	1 \
	0 \
--usrfs \
	upgrade/UsrFS.yaffs2 \
	0x15900000 \
	0x16500000 \
	1 \
	0 \
--usrdisk \
	upgrade/UsrDisk.yaffs2 \
	0x16500000 \
	0x40000000 \
	1 \
	0 
