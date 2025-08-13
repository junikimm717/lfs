#!/bin/sh

set -eu

DIR="$(realpath "$(dirname "$0" )" )"


if uname -m | grep -E 'arm|aarch' > /dev/null 2>&1; then
  export TARGET="aarch64-linux-musl"
  export BUILDTRIPLE="aarch64-linux-musl"
else
  export TARGET="x86_64-linux-musl"
  export BUILDTRIPLE="x86_64-linux-musl"
fi

export INOSENV=1

export CROSS_ROOT="$DIR/cross/$TARGET-native/$TARGET"
export PATH="$DIR/cross/$TARGET-native/bin:$PATH"
export CC="$DIR/cross/$TARGET-native/bin/$TARGET-gcc"
export CXX="$DIR/cross/$TARGET-native/bin/$TARGET-g++"
export CPP="$DIR/cross/$TARGET-native/bin/$TARGET-gcc -E"
export CXXCPP="$DIR/cross/$TARGET-native/bin/$TARGET-g++ -E"
export AR="$DIR/cross/$TARGET-native/bin/$TARGET-ar"
export RANLIB="$DIR/cross/$TARGET-native/bin/$TARGET-ranlib"
export LD="$DIR/cross/$TARGET-native/bin/$TARGET-ld"
export DIST="$DIR/dist"
export ROOTFS="$DIR/dist/rootfs"
export CFLAGS="-O2 -pipe -fPIC -w -I$ROOTFS/usr/include -I$ROOTFS/include -I$DIR/cross/$TARGET-native/$TARGET/include"
export CXXFLAGS="-O2 -pipe -fPIC -w -I$ROOTFS/usr/include -I$ROOTFS/include -I$DIR/cross/$TARGET-native/$TARGET/include"
export LDFLAGS="-s -L$ROOTFS/lib -L$ROOTFS/usr/lib -L$ROOTFS/usr/lib64 -L$DIR/cross/$TARGET-native/$TARGET/lib"
export PKG_CONFIG_SYSROOT_DIR="$ROOTFS"
export PKG_CONFIG_LIBDIR="$ROOTFS/usr/lib/pkgconfig"
export PKG_CONFIG_PATH="$ROOTFS/usr/share/pkgconfig"

export ESP_SIZE=64
export ROOT_SIZE=2048

"$DIR/cross/build" all
"$DIR/core/kernel/build" all
"$DIR/tools/setup_initramfs.sh"
"$DIR/tools/userspace.sh"
"$DIR/tools/bootable.sh"

echo "If you reached this point, congrats! check out ./dist for the bootable image and rootfs."
