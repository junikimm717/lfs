#!/bin/sh

set -eu

DIR="$(realpath "$(dirname "$0" )" )"

XORG="$DIR/../extra/xorg"
# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

# NOTE: we intentionally do NOT add $ROOTFS/usr/include to a global CPPFLAGS.
# Automake searches $(CPPFLAGS) before a target's $(AM_CFLAGS) (which carries the
# Xorg SDK's -I.../include/xorg), so a global -I$ROOTFS/usr/include would let
# musl's <shadow.h> shadow the server's xorg/shadow.h when a driver does
# #include "shadow.h". Packages that genuinely need CPPFLAGS (libpng's zlib.h
# prepass) set it themselves in their own build script.

# The X libraries form deep shared-object chains (e.g. xkbcomp -> libxkbfile ->
# libX11 -> libxcb -> libXau/libXdmcp). GNU ld only searches -L dirs for direct
# -l deps; it needs -rpath-link to resolve the *indirect* DT_NEEDED libraries of
# a sysroot at link time. This affects link-time search only -- no runtime rpath
# is baked into the binaries.
export LDFLAGS="${LDFLAGS:-} -Wl,-rpath-link,$ROOTFS/usr/lib -Wl,-rpath-link,$ROOTFS/lib -Wl,-rpath-link,$ROOTFS/usr/lib64"

# Core packages installed with prefix=/ (e.g. eudev) drop their pkg-config files
# under $ROOTFS/lib/pkgconfig, which the base env does not search. xorg-server's
# udev input backend needs libudev.pc from there.
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH:-}:$ROOTFS/lib/pkgconfig"

build() {
  echo "========= Building $1... ==========="
  "$XORG/$1/build" a
}

# The graphical stack is NOT part of the core bootable rootfs. It builds on top
# of a completed core userspace (tools/userspace.sh) and installs Xorg plus the
# libraries/drivers/fonts needed for a working graphical environment. Window
# managers, terminals, and other applications are layered on separately.

# ---- protocol headers + build macros ----
build util-macros
build xorgproto
build xcb-proto

# ---- xcb (bspwm/sxhkd are pure-xcb clients) ----
build libXau
build libXdmcp
build libxcb
build xcb-util
build xcb-util-keysyms
build xcb-util-wm
# xcb-image + xcb-renderutil are used by the picom compositor (extra/apps).
build xcb-util-image
build xcb-util-renderutil

# ---- Xlib client libraries ----
build xtrans
build libX11
build libXext
build libXrender
build libXfixes
build libXi
build libXrandr
build libXcursor
build libXinerama

# ---- font / text rendering ----
build libpng
build freetype
build expat
build fontconfig
build libXft
build font-util
build libfontenc
build libXfont2

# ---- keyboard handling ----
build libxkbfile
build xkeyboard-config
build xkbcomp

# ---- X server support libraries ----
build libpciaccess
build libxcvt
build libdrm
build pixman
build libevdev

# ---- the X server ----
build xorg-server

# ---- input + video drivers (fbdev drives /dev/fb0; no mesa/DRI needed) ----
# These build against the xorg-server SDK, so they must come after it. The
# modesetting DDX is not built (it needs gbm/mesa), so fbdev is the video path.
build mtdev
build xf86-input-evdev
build xf86-video-fbdev

echo "Graphical stack built. See extra/README.md for the layered application plan."
