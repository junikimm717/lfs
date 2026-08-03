#!/bin/sh

# script that installs files in /etc (and maybe others)

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

# get to the project root.
DIR="$(realpath "$(dirname "$0" )" )/.."
DIR="$(realpath "$DIR" )"

# copy over stuff in userspace
mkdir -p "$ROOTFS/home/mimi"
rsync -a "$DIR/etc/" "$ROOTFS/etc/" || exit 1

# Only ship gettys for ttys that exist on the target arch; runit respawns
# forever against an absent device. tty1/tty2 are VTs and exist on both.
case "${TARGET:-$(arch)}" in
  aarch64*|arm*)
    rm -rf "${ROOTFS:?}/etc/service/getty-ttyS0" "${ROOTFS:?}/etc/service/getty-ttyS1"
    ;;
  *)
    rm -rf "${ROOTFS:?}/etc/service/getty-ttyAMA0"
    ;;
esac

VERSION="0.1-dev-$(git rev-parse HEAD | head -c 7)"
echo "Mimux $VERSION ($(arch))" > "$ROOTFS/etc/issue"
echo "VERSION=\"$VERSION\"" >> "$ROOTFS/etc/os-release"
