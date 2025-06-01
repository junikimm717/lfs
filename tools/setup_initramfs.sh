#!/bin/sh

set -eu

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR/.."

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

mkdir -p "$DIST/initramfs"

# download everything first.
./cross/build d
./init/busybox/build d
./init/eudev/build d

# these must be done IN ORDER!
./cross/build all
./init/busybox/build all
./init/eudev/build all

cd "$DIST/initramfs"
mkdir -p bin dev etc lib tmp var boot proc run sys mnt
cp -a "$DIR/../misc/init" "$DIST/initramfs/init"
mkdir -p "$ROOTFS/boot"
find . | cpio -H newc -o | gzip > "$ROOTFS/boot/initramfs.cpio.gz"
