#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"

test -z "$INOSENV" && \
  echo "You cannot run this script while not in the juniosenv!" && \
  exit 1

ROOT_SIZE=1023

cd "$DIST" || exit 1
dd if=/dev/zero of=rootfs.img bs=1M count=$ROOT_SIZE || exit 1
# bruh fakeroot just shits itself if you're on x86_64
if [ "$(arch)" = "x86_64" ]; then
  mke2fs -t ext4 -F -d rootfs/ rootfs.img || exit 1
else
  fakeroot mke2fs -t ext4 -F -d rootfs/ rootfs.img || exit 1
fi

# Your one chance to set permissions correctly.
debugfs -w rootfs.img <<EOF
chmod 0644 /etc/passwd /etc/group
chmod 0640 /etc/shadow
chown 0 22 /etc/shadow
quit
EOF
