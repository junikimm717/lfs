#!/bin/sh
# linux_boot.sh -- boot the mimux bootable image in a GRAPHICAL QEMU window
# (UEFI). The Linux counterpart to tools/macos_boot.sh.
#
# Unlike tools/emulator.sh (which does a headless -nographic direct-kernel
# boot for quick console testing), this boots the real dist/bootable.img
# through OVMF/UEFI with a virtio-gpu display, so you can actually see Xorg +
# bspwm come up. It runs on the HOST (not inside the build container).
#
# Requires: qemu-system-x86_64 and OVMF UEFI firmware
#   Fedora:      dnf install qemu-system-x86 edk2-ovmf
#   Debian/Ubu:  apt install qemu-system-x86 ovmf
#
# Overridable via env: IMG, MEM (MB), SMP, DISPLAY_BACKEND (gtk|sdl).
# Any extra args are passed straight through to qemu, e.g.:
#   ./tools/linux_boot.sh -snapshot
set -eu

DIR="$(realpath "$(dirname "$0")")"
DIST="$DIR/../dist"

IMG="${IMG:-$DIST/bootable.img}"
MEM="${MEM:-2048}"
SMP="${SMP:-2}"
DISPLAY_BACKEND="${DISPLAY_BACKEND:-gtk}"
XRES="${XRES:-1280}"
YRES="${YRES:-720}"
# GL=on routes the guest scanout through the host's OpenGL for a lower-latency
# present path (helps the fbdev software cursor feel less laggy). Off by default
# since it needs working host GL; flip to on if your host supports it.
GL="${GL:-off}"

test -f "$IMG" || {
  echo "No bootable image at $IMG."
  echo "Build one first: (in the dev container) ./tools/bootable.sh"
  exit 1
}

command -v qemu-system-x86_64 >/dev/null 2>&1 || {
  echo "qemu-system-x86_64 not found. Install qemu (see header)."
  exit 1
}

# Locate OVMF firmware across common distro layouts.
OVMF_CODE=""
for f in \
  /usr/share/edk2/ovmf/OVMF_CODE.fd \
  /usr/share/OVMF/OVMF_CODE.fd \
  /usr/share/edk2-ovmf/x64/OVMF_CODE.fd \
  /usr/share/edk2/x64/OVMF_CODE.4m.fd \
  /usr/share/qemu/edk2-x86_64-code.fd ; do
  [ -f "$f" ] && { OVMF_CODE="$f"; break; }
done
OVMF_VARS_SRC=""
for f in \
  /usr/share/edk2/ovmf/OVMF_VARS.fd \
  /usr/share/OVMF/OVMF_VARS.fd \
  /usr/share/edk2-ovmf/x64/OVMF_VARS.fd \
  /usr/share/edk2/x64/OVMF_VARS.4m.fd \
  /usr/share/qemu/edk2-i386-vars.fd ; do
  [ -f "$f" ] && { OVMF_VARS_SRC="$f"; break; }
done
test -n "$OVMF_CODE" && test -n "$OVMF_VARS_SRC" || {
  echo "Could not find OVMF UEFI firmware."
  echo "Install it (Fedora: edk2-ovmf, Debian/Ubuntu: ovmf) or point this"
  echo "script at OVMF_CODE.fd / OVMF_VARS.fd manually."
  exit 1
}

# UEFI needs a WRITABLE variable store. Keep a per-image copy under dist/ so
# boot entries persist between runs; delete it to reset UEFI NVRAM.
OVMF_VARS="$DIST/OVMF_VARS.qemu.fd"
[ -f "$OVMF_VARS" ] || cp "$OVMF_VARS_SRC" "$OVMF_VARS"

# KVM acceleration when the host allows it.
if [ -w /dev/kvm ]; then
  ACCEL="-enable-kvm -cpu host"
else
  echo "note: /dev/kvm not writable; using software emulation (slow)."
  ACCEL="-cpu max"
fi

DISP="$DISPLAY_BACKEND"
[ "$GL" = "on" ] && DISP="$DISP,gl=on"

echo "Booting $IMG  (${MEM}MB, ${SMP} vCPU, display=$DISP)"
echo "Firmware: $OVMF_CODE"
echo "Log in as mimi / george, then run 'xstart' to launch bspwm."

# shellcheck disable=SC2086
exec qemu-system-x86_64 \
  -machine q35 \
  $ACCEL \
  -m "$MEM" \
  -smp "$SMP" \
  -drive if=pflash,format=raw,unit=0,readonly=on,file="$OVMF_CODE" \
  -drive if=pflash,format=raw,unit=1,file="$OVMF_VARS" \
  -drive file="$IMG",format=raw,if=virtio \
  -device virtio-vga,edid=on,xres="$XRES",yres="$YRES" \
  -display "$DISP" \
  -device virtio-keyboard-pci -device virtio-tablet-pci \
  -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
  -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci \
  -serial mon:stdio \
  "$@"
