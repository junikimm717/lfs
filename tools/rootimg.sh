#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"

test -z "$INOSENV" && \
  echo "You cannot run this script while not in the juniosenv!" && \
  exit 1

ROOT_SIZE=1023

cd "$DIST" || exit 1
dd if=/dev/zero of=rootfs.img bs=1M count=$ROOT_SIZE || exit 1
fakeroot mke2fs -t ext4 -F -d rootfs/ rootfs.img || exit 1
