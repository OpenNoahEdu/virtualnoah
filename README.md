# VirtualNoah

## Depend

### Debian

```
sudo apt install make gcc g++

# qemu
sudo apt install zlib1g-dev libsdl1.2-dev

sudo apt build-dep gcc

# uboot
sudo apt install libgcc-8-dev-mipsel-cross

# kernel
sudo apt install u-boot-tools
```

## Build

	git clone --depth 1 --recursive --shallow-submodules https://github.com/OpenNoahEdu/virtualnoah.git -b new
	cd virtualnoah
	./build.sh
