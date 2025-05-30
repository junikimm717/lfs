#!/bin/sh

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the juniosenv!" && \
  exit 1

build() {
  mkdir -p "$PKGS/log"
  echo "========= Building $1... ==========="
  "$PKGS/$1/build" a 2>&1 | tee -a "$PKGS/log/$1.log"
}

# libraries required by everything.
build openssl
build libc
build zlib
# readline depends on curses
build ncurses
build readline

# tools
build user_busybox
build runit
build eudev
build chrony
build dhcpcd
build opendoas
build fastfetch
build file
build make

# bootloader
build limine

# install the compiler and tools.
build gmp \
  && build mpfr \
  && build mpc \
  && build binutils \
  && build gcc
