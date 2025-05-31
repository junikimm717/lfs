#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"

CORE="$DIR/../core"
# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the juniosenv!" && \
  exit 1

build() {
  mkdir -p "$CORE/log"
  echo "========= Building $1... ==========="
  "$CORE/$1/build" a 2>&1 | tee -a "$CORE/log/$1.log"
}

mkdir -m 700 -p "$ROOTFS/root"
mkdir -m 755 -p "$ROOTFS/run" "$ROOTFS/home" "$ROOTFS/proc" "$ROOTFS/sys" "$ROOTFS/dev/pts" "$ROOTFS/dev/shm" "$ROOTFS/dev/run"
mkdir -m 755 -p "$ROOTFS/boot/efi"

{
  # libraries required by everything.
  build openssl && \
  build libc && \
  build zlib && \
  build certs
} && {
  # readline depends on curses
  # curl depends on nghttp2
  build ncurses && \
  build readline && \
  build nghttp2 && \
  build bzip2 && \
  build xz && \
  build libffi && \
  build sqlite
} && {
  # tools
  build user_busybox && \
  build runit && \
  build eudev && \
  build chrony && \
  build dhcpcd && \
  build opendoas && \
  build fastfetch && \
  build file && \
  build make && \
  build util-linux &&
  build curl
} && {
  # bootloader
  build limine
} && {
  # install the compiler and tools.
  build gmp && \
  build mpfr && \
  build mpc && \
  build binutils && \
  build gcc
}

# copy over stuff in userspace
rsync -a "$DIR/../etc/" "$ROOTFS/etc/" || exit 1
