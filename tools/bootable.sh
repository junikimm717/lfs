#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"
ESP_SIZE="$(grep 'ESP_SIZE=' $DIR/esp.sh | cut -d'=' -f 2)"
ROOT_SIZE="$(grep 'ROOT_SIZE=' $DIR/rootimg.sh | cut -d'=' -f 2)"

ESP_SECTORS=$((ESP_SIZE * 2048))
ROOTFS_SECTORS=$((ROOT_SIZE * 2048))

ESP_START=2048
ROOTFS_START=$((ESP_START + ESP_SECTORS))

TOTAL_SECTORS=$((ROOTFS_START + ROOTFS_SECTORS))
TOTAL_SIZE=$(((TOTAL_SECTORS * 512) / 1048576 + 1))

test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

cd "$DIST" || exit 1

$DIR/re_initramfs.sh || exit 1
$DIR/rootimg.sh || exit 1
$DIR/esp.sh || exit 1

dd if=/dev/zero of=bootable.img bs=1M count=$TOTAL_SIZE

sgdisk --clear \
  --new=1:${ESP_START}:$((ESP_START + ESP_SECTORS - 1)) \
  --typecode=1:ef00 --change-name=1:ESP \
  --new=2:${ROOTFS_START}:$((ROOTFS_START + ROOTFS_SECTORS - 1)) \
  --typecode=2:8300 --change-name=2:RootFS \
  --print \
  bootable.img

dd if=esp.img of=bootable.img bs=512 seek=$ESP_START conv=notrunc
dd if=rootfs.img of=bootable.img bs=512 seek=$ROOTFS_START conv=notrunc
