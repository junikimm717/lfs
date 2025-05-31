#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"

test -z "$INOSENV" && \
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1

ESP_SIZE=64

cd "$DIST" || exit 1
dd if=/dev/zero of=esp.img bs=1M count=$ESP_SIZE || exit 1
mkfs.vfat -F 32 esp.img

export MTOOLS_SKIP_CHECK=1
mmd -i esp.img ::/EFI
mmd -i esp.img ::/EFI/BOOT
mmd -i esp.img ::/BOOT

bootloader=$(find "$ROOTFS/usr/share/limine" -name "*.EFI")
test -z $bootloader && {
  echo "You do not have a bootloader installed!"
  exit 1
}

rootuuid=$(tune2fs -l rootfs.img | grep 'UUID' | awk '{print $3}')
kernel="$(basename "$(find "$ROOTFS/boot" -name 'vmlinu*' | sort | head -n 1)")"

test -z "$kernel" -o -z "$rootuuid" && exit 1

mcopy -i esp.img $bootloader ::/EFI/BOOT/$(basename $bootloader)
mcopy -i esp.img "$ROOTFS/boot/$kernel" ::/BOOT/$kernel
mcopy -i esp.img "$ROOTFS/boot/initramfs.cpio.gz" ::/BOOT/initramfs.cpio.gz

cat <<EOF > ./limine.conf
timeout: 5

/Mimux $kernel
    protocol: linux
    path: boot():/boot/$kernel
    cmdline:panic=-1 root=UUID=$rootuuid rw
    module_path: boot():/boot/initramfs.cpio.gz

/Mimux $kernel (logs)
    protocol: linux
    path: boot():/boot/$kernel
    cmdline:console=tty0 panic=5 root=UUID=$rootuuid rw
    module_path: boot():/boot/initramfs.cpio.gz

/Mimux $kernel (debug shell)
    protocol: linux
    path: boot():/boot/$kernel
    cmdline:console=tty0 panic=5 debug=true
    module_path: boot():/boot/initramfs.cpio.gz
EOF

mcopy -i esp.img ./limine.conf ::/EFI/BOOT/
