#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"

cd "$DIR" || exit 1
cd ../dist || { echo "rootfs doesn't exit!"; exit 1; }

if test -z "${1:-}"; then
  echo "\$1 is undefined for x86 booter."
  exit 1
fi

qemu-system-x86_64 \
  -m 8192 \
  -smp 4 \
  -drive if=pflash,format=raw,readonly=on,file="$(brew --prefix qemu)/share/qemu/edk2-x86_64-code.fd" \
  -drive file="$1",format=raw,if=virtio \
  -no-reboot \
  -net nic -net user\
  -device qemu-xhci -usb -device usb-kbd\
  -device virtio-gpu-pci -display cocoa\
  -device virtio-rng-pci\
  -object rng-random,filename=/dev/urandom,id=rng0\
  -nographic -serial mon:stdio
