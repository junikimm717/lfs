#!/bin/sh

set -eu

# DIR="$(realpath "$(dirname "$0" )" )"

test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

ESP_SIZE="${ESP_SIZE:-64}"

cd "$DIST"
dd if=/dev/zero of=esp.img bs=1M count="$ESP_SIZE"
mkfs.vfat -F 32 esp.img

export MTOOLS_SKIP_CHECK=1
mmd -i esp.img ::/EFI
mmd -i esp.img ::/EFI/BOOT
mmd -i esp.img ::/BOOT

bootloader=$(find "$ROOTFS/usr/share/limine" -name "*.EFI")
test -z "$bootloader" && {
  echo "You do not have a bootloader installed!"
  exit 1
}

rootuuid=$(tune2fs -l rootfs.img | grep 'UUID' | awk '{print $3}')
kernel="$(basename "$(find "$ROOTFS/boot" -name 'vmlinu*' | sort -r | head -n 1)")"

# x86_64 serial is 8250/ttyS0, aarch64 virt is PL011/ttyAMA0; both drivers are
# built into the kernel. The last console= becomes /dev/console, so serial goes
# last: printk reaches both, but init output and the initramfs debug shell stay
# visible on a headless boot.
case "${TARGET:-$(arch)}" in
  aarch64*|arm*) serialconsole="ttyAMA0" ;;
  *)             serialconsole="ttyS0" ;;
esac
console="console=tty0 console=$serialconsole,115200"

test -z "$kernel" -o -z "$rootuuid" && exit 1

mcopy -i esp.img "$bootloader" "::/EFI/BOOT/$(basename "$bootloader")"
mcopy -i esp.img "$ROOTFS/boot/$kernel" "::/BOOT/$kernel"
mcopy -i esp.img "$ROOTFS/boot/initramfs.cpio.gz" ::/BOOT/initramfs.cpio.gz

cat <<EOF > "$DIST/limine.conf"
timeout: 5

/Mimux $kernel
    protocol: linux
    path: boot():/boot/$kernel
    cmdline:$console panic=-1 root=UUID=$rootuuid rw
    module_path: boot():/boot/initramfs.cpio.gz

/Mimux $kernel (logs)
    protocol: linux
    path: boot():/boot/$kernel
    cmdline:$console panic=5 root=UUID=$rootuuid rw
    module_path: boot():/boot/initramfs.cpio.gz

/Mimux $kernel (debug shell)
    protocol: linux
    path: boot():/boot/$kernel
    cmdline:$console panic=5 debug=true
    module_path: boot():/boot/initramfs.cpio.gz
EOF

mcopy -i esp.img "$DIST/limine.conf" ::/EFI/BOOT/
