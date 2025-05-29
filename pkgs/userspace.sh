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

# required by everything.
build openssl
build libc

build ncurses
build user_busybox

# libraries
build zlib

# bootloader
build limine

# tools
build runit
build eudev
build chrony
build dhcpcd
build opendoas
build fastfetch
build file
