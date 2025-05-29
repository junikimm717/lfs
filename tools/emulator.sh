#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"

cd "$DIR" || exit 1
cd ../dist || { echo "rootfs doesn't exit!"; exit 1; }

KERNEL=$(find ./rootfs -name 'vmlinuz*' | head -n 1)
INITRD="./emulator.cpio.gz"

test -z "$KERNEL" -o -z "$INITRD" && {
  echo "could not find kernel or initrd; please use the ./tools/setup_initramfs.sh";
  exit 1;
}

EMULATOR=qemu-system-x86_64
if arch | grep -E "arm|aarch" > /dev/null 2>&1; then
  EMULATOR=qemu-system-aarch64
fi

$EMULATOR \
  -machine virt \
  -cpu cortex-a72 \
  -m 1024 \
  -kernel $KERNEL \
  -initrd $INITRD \
  -nographic -append "console=ttyAMA0 panic=-1 root=/dev/vda rw" \
  -drive file=./rootfs.img,format=raw,if=virtio \
  -no-reboot \
  -net nic -net user
