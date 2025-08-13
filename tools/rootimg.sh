#!/bin/sh

set -eu

# DIR="$(realpath "$(dirname "$0" )" )"

test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

cd "$DIST" || exit 1

chown -R 0:0 "$ROOTFS" || true
chmod 640 "$ROOTFS/etc/passwd"
chmod 644 "$ROOTFS/etc/passwd"
chmod 644 "$ROOTFS/etc/group"
chmod 777 "$ROOTFS/tmp"
chmod 700 "$ROOTFS/home/mimi"
chmod 4755 "$ROOTFS/usr/bin/doas"\
  "$ROOTFS/bin/su"\
  "$ROOTFS/usr/bin/passwd"\
  "$ROOTFS/bin/mount"\
  "$ROOTFS/bin/umount"\
  "$ROOTFS/bin/ping"\
  "$ROOTFS/bin/ping6"

chown -R 0:22 "$ROOTFS/etc/shadow"
chown -R 1000:1000 "$ROOTFS/home/mimi"
cd "$ROOTFS" || exit 1
tar czpf "../rootfs-$(arch).tar.gz" \
  --exclude='./boot/vmlinux-*' \
  --exclude='./boot/System.map-*' \
  --exclude='./boot/*.cpio.gz' \
  .

cd "$DIST" || exit 1
ROOT_SIZE="${ROOT_SIZE:-2048}"

dd if=/dev/zero of=rootfs.img bs=1M count="$ROOT_SIZE" || exit 1
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
set_inode_field /tmp mode 0040777

set_inode_field /home/mimi mode 0040700
set_inode_field /home/mimi uid 1000
set_inode_field /home/mimi gid 1000

set_inode_field /usr/bin/doas mode 0104755
set_inode_field /bin/su mode 0104755
set_inode_field /usr/bin/passwd mode 0104755
set_inode_field /bin/mount mode 0104755
set_inode_field /bin/umount mode 0104755
set_inode_field /bin/ping mode 0104755
set_inode_field /bin/ping6 mode 0104755

quit
EOF

printf "\n"
