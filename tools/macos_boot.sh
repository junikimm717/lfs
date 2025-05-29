#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"

cd "$DIR" || exit 1
cd ../dist || { echo "rootfs doesn't exit!"; exit 1; }

qemu-system-aarch64 \
  -machine virt \
  -cpu cortex-a72 \
  -m 1024 \
  -drive if=pflash,format=raw,readonly=on,file="$(brew --prefix qemu)/share/qemu/edk2-aarch64-code.fd" \
  -drive file=./bootable.img,format=raw,if=virtio \
  -no-reboot \
  -net nic -net user\
  -device virtio-gpu-pci -display cocoa
  #-nographic -serial mon:stdio\
  #-drive if=pflash,format=raw,file=$(brew --prefix qemu)/share/qemu/edk2-arm-vars.fd \
