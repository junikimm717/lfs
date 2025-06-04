#!/bin/sh

set -eu

DIR="$(realpath "$(dirname "$0" )" )"

"$DIR/core/kernel/build all"
"$DIR/tools/setup_initramfs.sh"
"$DIR/tools/userspace.sh"
"$DIR/tools/bootable.sh"

echo "If you reached this point, congrats! check out ./dist for the bootable image and rootfs."
