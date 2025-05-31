#!/bin/sh

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

DIR="$(realpath "$(dirname "$0" )" )"

cp -a "$DIR/../misc/init" "$DIST/initramfs/init"
cd "$DIST/initramfs" || exit 1
mkdir -p "$ROOTFS/boot"
find . | cpio -H newc -o | gzip > "$ROOTFS/boot/initramfs.cpio.gz"
