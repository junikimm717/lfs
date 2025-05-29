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
_OLD_PATH="\$PATH"
_OLD_CC="\$CC"
_OLD_CXX="\$CXX"
_OLD_AR="\$AR"
_OLD_RANLIB="\$RANLIB"
_OLD_LD="\$LD"
_OLD_CFLAGS="\$CFLAGS"
_OLD_CXXFLAGS="\$CXXFLAGS"
_OLD_LDFLAGS="\$LDFLAGS"
_OLD_JOBS="\$JOBS"

deactivate() {
  export PATH="\$_OLD_PATH"
  export CC=\$_OLD_CC
  export AR=\$_OLD_AR
  export RANLIB=\$_OLD_RANLIB
  export LD=\$_OLD_LD
  export CFLAGS=\$_OLD_CFLAGS
  export CXXFLAGS=\$_OLD_CXXFLAGS
  export LDFLAGS=\$_OLD_LDFLAGS
  export JOBS=\$_OLD_JOBS

  unset _OLD_CC
  unset _OLD_CXX
  unset _OLD_AR
  unset _OLD_RANLIB
  unset _OLD_LD
  unset _OLD_JOBS

  unset HGCCVER
  unset BUILDTRIPLE
  unset TARGET
  unset INOSENV
  unset DIST
  unset ROOTFS
  unset PKGS

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

export VIRTUAL_ENV="junios"
export PATH="$DIR/cross/$TARGET-native/bin:\$PATH"
export CC="$DIR/cross/$TARGET-native/bin/$TARGET-gcc"
export CXX="$DIR/cross/$TARGET-native/bin/$TARGET-g++"
export AR="$DIR/cross/$TARGET-native/bin/$TARGET-ar"
export RANLIB="$DIR/cross/$TARGET-native/bin/$TARGET-ranlib"
export LD="$DIR/cross/$TARGET-native/bin/$TARGET-ld"
export DIST="$DIR/dist"
export ROOTFS="$DIR/dist/rootfs"
export CFLAGS="\$CFLAGS -O2 -pipe -w -I\$ROOTFS/usr/include -I\$ROOTFS/include -I$DIR/cross/$TARGET-native/$TARGET/include"
export CXXFLAGS="\$CXXFLAGS -O2 -pipe -w -I\$ROOTFS/usr/include -I\$ROOTFS/include -I$DIR/cross/$TARGET-native/$TARGET/include"
export LDFLAGS="\$LDFLAGS -s -L\$ROOTFS/lib -L\$ROOTFS/usr/lib -L\$ROOTFS/usr/lib64 -L$DIR/cross/$TARGET-native/$TARGET/lib"

JOBS=$(($(nproc)-2))
if [ \$JOBS -lt 0 ]; then
  JOBS=$(nproc)
fi
export JOBS

export TARGET="$TARGET"
export HGCCVER="$HGCCVER"
export BUILDTRIPLE="$BUILDTRIPLE"
export INOSENV=1
export PKGS="$DIR/pkgs"

_OLD_VIRTUAL_PS1="\${PS1:-}"
PS1='(junios) '"\${PS1:-}"
export PS1
VIRTUAL_ENV_PROMPT='(junios) '
export VIRTUAL_ENV_PROMPT
set -o vi
EOF
