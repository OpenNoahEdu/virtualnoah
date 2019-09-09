# VirtualNoah

## Depend

### Debian

```
sudo apt install make gcc g++ zlib1g-dev libsdl1.2-dev libgcc-8-dev-mipsel-cross u-boot-tools unrar
sudo apt build-dep gcc
```

## Build

	git clone --depth 1 --recursive --shallow-submodules https://github.com/OpenNoahEdu/virtualnoah.git -b new
	cd virtualnoah
	./build.sh

## Run

	./qemu-JZ/mipsel-softmmu/qemu-system-mipsel -show-cursor -serial pty -M pavo -cpu jz4740 -mtdblock ./nandflash.bin