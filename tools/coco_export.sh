#!/bin/sh

# script that exports the extra/ package tree into the rootfs at /coco, so a
# booted mimux can build the opt-in layers with coco.

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

# get to the project root.
DIR="$(realpath "$(dirname "$0" )" )/.."
DIR="$(realpath "$DIR" )"

echo "exporting extra/ to /coco..."

mkdir -p "$ROOTFS/coco"
# --delete so a package removed from extra/ does not linger in an incrementally
# rebuilt rootfs. --no-o/--no-g matches how etc/ and perl's core modules are
# staged; the tree is owned by root and world-readable, and building from it
# stages elsewhere (coco's $BUILDDIR) so it never needs to be writable.
rsync -a --no-o --no-g --delete "$DIR/extra/" "$ROOTFS/coco/" || exit 1
