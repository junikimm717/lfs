#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"

cd "$DIR" || exit 1
cd ../dist || { echo "rootfs doesn't exit!"; exit 1; }

KERNEL=$(find ./rootfs -name 'vmlinu*' | sort | head -n 1)
INITRD=./rootfs/boot/initramfs.cpio.gz
if test "$1" = "-d"; then
  INITRD="./debug.cpio.gz"
fi

test -z "$KERNEL" -o -z "$INITRD" && {
  echo "could not find kernel or initrd; please use the ./tools/setup_initramfs.sh";
  exit 1;
}

if arch | grep -E "arm|aarch" > /dev/null 2>&1; then
  qemu-system-aarch64\
    -machine virt \
    -cpu cortex-a72 \
    -m 1024 \
    -kernel "$KERNEL" \
    -initrd "$INITRD" \
    -nographic -append "console=ttyAMA0 panic=-1 root=/dev/vda rw" \
    -drive file=./rootfs.img,format=raw,if=virtio \
    -no-reboot \
    -net nic -net user
elif arch | grep -E "x86" > /dev/null 2>&1; then
  qemu-system-x86_64\
    -machine q35 \
    -m 1024 \
    -kernel "$KERNEL" \
    -initrd "$INITRD" \
    -nographic -append "console=ttyAMA0 panic=-1 root=/dev/vda rw" \
    -drive file=./rootfs.img,format=raw,if=virtio \
    -no-reboot \
    -netdev user,id=net0 \
    -device e1000,netdev=net0
else
  exit 1
fi

