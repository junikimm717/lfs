#!/bin/sh

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the juniosenv!" && \
  exit 1

DIR="$(realpath "$(dirname "$0" )" )"

cd "$DIST/initramfs" || exit 1
mkdir -p "$ROOTFS/boot"
find . | cpio -H newc -o | gzip > "$ROOTFS/boot/initramfs.cpio.gz"

cd "$DIST/emulatorfs" || exit 1
find . | cpio -H newc -o | gzip > "$DIST/emulator.cpio.gz"
