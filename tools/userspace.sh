#!/bin/sh

set -eu

DIR="$(realpath "$(dirname "$0" )" )"

CORE="$DIR/../core"
# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

build() {
  mkdir -p "$CORE/log"
  echo "========= Building $1... ==========="
  "$CORE/$1/build" a
}

mkdir -p "$ROOTFS/root" \
  "$ROOTFS/run" "$ROOTFS/home" "$ROOTFS/proc" "$ROOTFS/sys" \
  "$ROOTFS/dev/pts" "$ROOTFS/dev/shm" "$ROOTFS/dev/run" "$ROOTFS/usr/lib" \
  "$ROOTFS/boot/efi"
  "$ROOTFS/tmp"

chmod 700 "$ROOTFS/root"
chmod 755 "$ROOTFS/run" "$ROOTFS/home" "$ROOTFS/proc" "$ROOTFS/sys" \
  "$ROOTFS/dev/pts" "$ROOTFS/dev/shm" "$ROOTFS/dev/run" "$ROOTFS/boot/efi"\
  "$ROOTFS/usr/lib"
chmod 777 "$ROOTFS/tmp"

# MAKE sure to not run lib64
rm -rf "$ROOTFS/usr/lib64"
ln -sfn lib "$ROOTFS/usr/lib64"

"$DIR/etc_update.sh"
ln -sfn /usr/share/zoneinfo/America/New_York "$ROOTFS/etc/localtime"

# libraries required by everything.
build openssl
build libc
build busybox
build perl
build zlib
build certs
build tzdata
# readline depends on curses
build ncurses
build readline
# building dependencies, etc. for python3
build bzip2
build xz
build libffi
build sqlite
build python3
# tools
build runit
build eudev
build chrony
build dhcpcd
build opendoas
build fastfetch
build file
build make
build util-linux
# curl depends on nghttp2
build nghttp2
build curl
# bootloader
build limine
# install the compiler and tools.
build gmp
build mpfr
build mpc
build binutils
build gcc
build mandoc
build kbd
