#!/usr/bin/env bash

set -e

GENIMAGE_CFG="$2"

# copy the initramfs from br_initramfs to br_mainfs binaries directory
cp "${BR2_EXTERNAL_INITRAMFS_PATH}"/images/zImage "${BINARIES_DIR}"/
cp "${BR2_EXTERNAL_INITRAMFS_PATH}"/images/at91-sama5d27_som1_ek.dtb "${BINARIES_DIR}"/

# copy boot logo
cp "${BR2_EXTERNAL_MAINFS_PATH}"/board/microchip/sama5d27_som1_ek/logo.bmp "${BINARIES_DIR}"/

# create sdcard.img
support/scripts/genimage.sh -c "${GENIMAGE_CFG}"

# create bmap file
"${HOST_DIR}"/bin/bmaptool create -o "${BINARIES_DIR}"/sdcard.bmap "${BINARIES_DIR}"/sdcard.img

