#!/bin/sh

set -eu

DIR="$(realpath "$(dirname "$0" )" )"

APPS="$DIR/../extra/apps"
# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

# The application layer builds on top of a completed graphical stack
# (tools/graphical.sh). It installs a floating window manager (bspwm), its
# hotkey daemon (sxhkd), a terminal (st), a launcher (xinit), a font (DejaVu),
# and the default session config. None of this is part of the core rootfs.

# Same sysroot link/pkg-config wiring as the graphical build: the apps link
# deep X shared-object chains (bspwm -> xcb-util-wm -> libxcb, st -> libX11 ->
# libxcb ...), which need -rpath-link to resolve indirect DT_NEEDED libs, and
# eudev's libudev.pc lives under $ROOTFS/lib/pkgconfig.
export LDFLAGS="${LDFLAGS:-} -Wl,-rpath-link,$ROOTFS/usr/lib -Wl,-rpath-link,$ROOTFS/lib -Wl,-rpath-link,$ROOTFS/usr/lib64"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH:-}:$ROOTFS/lib/pkgconfig"

build() {
  echo "========= Building $1... ==========="
  "$APPS/$1/build" a
}

# ---- font (needed for anything to render text) ----
build dejavu-fonts

# ---- session launcher ----
build xinit

# ---- imaging libraries (Imlib2 stack for the wallpaper setter) ----
build libjpeg
build imlib2

# ---- terminal ----
build st

# ---- window manager + hotkey daemon ----
build bspwm
build sxhkd

# ---- status bar (lemonbar panel) + launcher ----
build lemonbar
build slstatus
build xtitle
build dmenu

# ---- compositor (transparency) + its libraries ----
build uthash
build libev
build libconfig
build picom

# ---- wallpaper setter ----
build feh

# ---- default session configuration ----
build config

echo "Application layer built. Log in as mimi and run 'xstart' to launch bspwm."
