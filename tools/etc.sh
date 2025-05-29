#!/bin/sh

# script that installs files in /etc (and maybe others)

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the juniosenv!" && \
  exit 1

DIR="$(realpath "$(dirname "$0" )" )/.."
DIR="$(realpath "$DIR" )"


rsync --delete -a $DIR/etc/ "$ROOTFS/etc/" || exit 1

if [ -r /etc/ssl/certs/ca-certificates.crt ]; then
  echo "Ripping host ca-certificates :)"
  mkdir -p "$ROOTFS/etc/ssl"
  cp /etc/ssl/certs/ca-certificates.crt "$ROOTFS/etc/ssl/cert.pem"
fi

mkdir -m 700 -p "$ROOTFS/root"
mkdir -m 755 -p "$ROOTFS/run" "$ROOTFS/home" "$ROOTFS/proc" "$ROOTFS/sys" "$ROOTFS/dev/pts" "$ROOTFS/dev/shm" "$ROOTFS/dev/run"
mkdir -m 755 -p "$ROOTFS/boot/efi"

# setting permissions
chmod 644 "$ROOTFS/etc/passwd" "$ROOTFS/etc/group"
chmod 640 "$ROOTFS/etc/shadow"
