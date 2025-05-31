#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR/.." || exit 1

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the juniosenv!" && \
  exit 1

mkdir -p "$DIST/initramfs"

# download everything first.
./cross/build d
./init/busybox/build d
./init/eudev/build d

# these must be done IN ORDER!
./cross/build all || exit 1
./init/busybox/build all || exit 1
./init/eudev/build all || exit 1

cd "$DIST/initramfs" || exit 1
mkdir -p bin dev etc lib tmp var boot proc run sys mnt
cp -a "$DIR/../misc/init" "$DIST/initramfs/init"
cp -a "$DIR/../misc/init.shell" "$DIST/initramfs/init.shell"
mkdir -p "$ROOTFS/boot"
find . | cpio -H newc -o | gzip > "$ROOTFS/boot/initramfs.cpio.gz"
