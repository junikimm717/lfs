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
set_inode_field /etc/passwd mode 0100644
set_inode_field /etc/group  mode 0100644
set_inode_field /etc/shadow mode 0100640
set_inode_field /etc/shadow uid 0
set_inode_field /etc/shadow gid 22

set_inode_field /home/mimi mode 0040700
set_inode_field /home/mimi uid 1000
set_inode_field /home/mimi gid 1000
quit
EOF
