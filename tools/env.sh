#!/bin/sh

# script to take care of environment variables necessary during the build process.

DIR="$(realpath "$(dirname "$0" )" )/.."
DIR="$(realpath "$DIR" )"

if uname -m | grep -E 'arm|aarch' 2>&1 > /dev/null; then
  TARGET="aarch64-linux-musl"
  BUILDTRIPLE="aarch64-linux-musl"
else
  TARGET="x86_64-linux-musl"
  BUILDTRIPLE="x86_64-linux-musl"
fi

cat <<EOF
if test -n \$BASH_VERSION -a -r /etc/profile; then
  source /etc/profile
fi

export _OLD_PATH="\$PATH"
export _OLD_CC="\$CC"
export _OLD_CXX="\$CXX"
export _OLD_CPP="\$CPP"
export _OLD_CXXCPP="\$CXXCPP"
export _OLD_AR="\$AR"
export _OLD_RANLIB="\$RANLIB"
export _OLD_LD="\$LD"
export _OLD_CFLAGS="\$CFLAGS"
export _OLD_CXXFLAGS="\$CXXFLAGS"
export _OLD_LDFLAGS="\$LDFLAGS"
export _OLD_JOBS="\$JOBS"
export _OLD_PKG_CONFIG_SYSROOT_DIR="\$PKG_CONFIG_SYSROOT_DIR"
export _OLD_PKG_CONFIG_LIBDIR=\$PKG_CONFIG_LIBDIR
export _OLD_PKG_CONFIG_PATH=\$PKG_CONFIG_PATH

deactivate() {
  export PATH="\$_OLD_PATH"
  export CC=\$_OLD_CC
  export CXX=\$_OLD_CXX
  export CPP=\$_OLD_CPP
  export CXXCPP=\$_OLD_CXXCPP
  export AR=\$_OLD_AR
  export RANLIB=\$_OLD_RANLIB
  export LD=\$_OLD_LD
  export CFLAGS=\$_OLD_CFLAGS
  export CXXFLAGS=\$_OLD_CXXFLAGS
  export LDFLAGS=\$_OLD_LDFLAGS
  export JOBS=\$_OLD_JOBS
  export PKG_CONFIG_SYSROOT_DIR=\$_OLD_PKG_CONFIG_SYSROOT_DIR
  export PKG_CONFIG_LIBDIR=\$_OLD_PKG_CONFIG_LIBDIR
  export PKG_CONFIG_PATH=\$_OLD_PKG_CONFIG_PATH

  unset _OLD_CC
  unset _OLD_CXX
  unset _OLD_AR
  unset _OLD_RANLIB
  unset _OLD_LD
  unset _OLD_JOBS
  unset _OLD_LD_LIBRARY_PATH
  unset _OLD_PKG_CONFIG_PATH
  unset _OLD_PKG_CONFIG_LIBDIR
  unset _OLD_PKG_CONFIG_SYSROOT_DIR

  unset BUILDTRIPLE
  unset TARGET
  unset INOSENV
  unset DIST
  unset ROOTFS

  hash -r 2> /dev/null

  if [ -n "\${_OLD_VIRTUAL_PS1:-}" ] ; then
      PS1="\${_OLD_VIRTUAL_PS1:-}"
      export PS1
      unset _OLD_VIRTUAL_PS1
  fi

  unset VIRTUAL_ENV
  unset VIRTUAL_ENV_PROMPT

  unset -f deactivate
}
export -f deactivate

export TARGET="$TARGET"
export BUILDTRIPLE="$BUILDTRIPLE"
export INOSENV=1

# ALL of these need to change if you have a source tree.
export PATH="$DIR/cross/$TARGET-native/bin:\$PATH"
export CC="$DIR/cross/$TARGET-native/bin/$TARGET-gcc"
export CXX="$DIR/cross/$TARGET-native/bin/$TARGET-g++"
export CPP="$TARGET-gcc -E"
export CXXCPP="$TARGET-g++ -E"
export AR="$DIR/cross/$TARGET-native/bin/$TARGET-ar"
export RANLIB="$DIR/cross/$TARGET-native/bin/$TARGET-ranlib"
export LD="$DIR/cross/$TARGET-native/bin/$TARGET-ld"
export DIST="$DIR/dist"
export ROOTFS="$DIR/dist/rootfs"
export CFLAGS="\$CFLAGS -O2 -pipe -fPIC -w -I\$ROOTFS/usr/include -I\$ROOTFS/include -I$DIR/cross/$TARGET-native/$TARGET/include"
export CXXFLAGS="\$CXXFLAGS -O2 -pipe -fPIC -w -I\$ROOTFS/usr/include -I\$ROOTFS/include -I$DIR/cross/$TARGET-native/$TARGET/include"
export LDFLAGS="\$LDFLAGS -s -L\$ROOTFS/lib -L\$ROOTFS/usr/lib -L\$ROOTFS/usr/lib64 -L$DIR/cross/$TARGET-native/$TARGET/lib"

export VIRTUAL_ENV="mimux"
export PKG_CONFIG_SYSROOT_DIR=$ROOTFS
export PKG_CONFIG_LIBDIR=$ROOTFS/usr/lib/pkgconfig
export PKG_CONFIG_PATH=$ROOTFS/usr/share/pkgconfig

JOBS=$(($(nproc)-2))
if [ \$JOBS -lt 0 ]; then
  JOBS=$(nproc)
fi
export JOBS

export _OLD_VIRTUAL_PS1="\${PS1:-}"
PS1='(mimux) '"\${PS1:-}"
export PS1
VIRTUAL_ENV_PROMPT='(mimux) '
export VIRTUAL_ENV_PROMPT
set -o vi
EOF
