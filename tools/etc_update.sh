#!/bin/sh

# script that installs files in /etc (and maybe others)

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the juniosenv!" && \
  exit 1

# get to the project root.
DIR="$(realpath "$(dirname "$0" )" )/.."
DIR="$(realpath "$DIR" )"

# copy over stuff in userspace
rsync --delete -a "$DIR/etc/" "$ROOTFS/etc/" || exit 1
