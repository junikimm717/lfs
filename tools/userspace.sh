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

mkdir -m 700 -p "$ROOTFS/root"
mkdir -m 755 -p "$ROOTFS/run" "$ROOTFS/home" "$ROOTFS/proc" "$ROOTFS/sys" "$ROOTFS/dev/pts" "$ROOTFS/dev/shm" "$ROOTFS/dev/run"
mkdir -m 755 -p "$ROOTFS/boot/efi"

"$DIR/etc_update.sh"

# libraries required by everything.
build openssl
build libc
build busybox
build zlib
build certs
# readline depends on curses
# curl depends on nghttp2
build ncurses
build readline
build nghttp2
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
build curl
# bootloader
build limine
# install the compiler and tools.
build gmp
build mpfr
build mpc
build binutils
build gcc
# building dependencies, etc. for python3
build bzip2
build xz
build libffi
build sqlite
build python3
