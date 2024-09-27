#  buildroot-external-initramfs
This repo contains buildroot external trees to create an image containing and kernel with initramfs and a main image.  The initramfs will perform a switch_root to the main image after booting.

This is intended to be a starting point to develop applications that require an initramfs architecture.

# How to build
### 0. Clone this repsitory and change directory into it.

### 1. Clone required repositories
git clone https://github.com/linux4microchip/buildroot-mchp.git -b linux4microchip-2024.04 \
git clone https://github.com/linux4microchip/buildroot-external-microchip.git -b linux4microchip-2024.04

### 2. build the initramfs image for your target (see configs directory)
cd br_initramfs \
make O=$PWD BR2_EXTERNAL=$PWD/../buildroot-external-microchip:$PWD -C $PWD/../buildroot-mchp initramfs_sama5d27_som1_ek_defconfig \
make

### 3. build the main filesystem image for your target (see configs directory)
cd br_mainfs
make O=$PWD BR2_EXTERNAL=$PWD/../buildroot-external-microchip:$PWD/../br_initramfs:$PWD -C $PWD/../buildroot-mchp mainfs_sama5d27_som1_ek_defconfig \
make

### 4. Flash the sdcard.img
#### Using the Microchip sam-ba utility
Ensure the SDCard is not in the slot and reset or cold power the board, then insert the SDCard \

sam-ba -p serial -b sama5d27-som1-ek -a sdmmc -c write:images/sdcard.img

#### Using the bmap utility
Insert the SDCard into a card reader on your host PC.  If it auto mounts, unmount it but do not remove the card \

bmaptool copy images/sdcard.img /dev/mmcblk0