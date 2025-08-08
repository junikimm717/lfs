# Mimux Tools

This directory contains all the tools necessary to both build and test mimux.
File names have been specifically chosen to minimize autocompletion time.

## Non-Container Tools

These are tools that should be run on your local machine when necessary.

- [./pkg.sh](./pkg.sh) - Creates a new package with a build script at the
  specified directory. Reference the [core readme](../core/README.md) for
  further information.
- [./dev.sh](./dev.sh) - Launches a shell into the dev container (assuming that
  you started that first)

The following scripts may only be used on M-series macs and are used to test
various components of mimux. All tools below **require qemu** to be installed via
homebrew.

- [./emulator.sh](./emulator.sh) - tests the rootfs at `/dist/rootfs.img` while
  launching the kernel separately. The entire setup operates inside the
  terminal. Not used too much anymore since we can now construct bootable disk
  images.
- [./macos_boot.sh](./macos_boot.sh) - tests the bootable image at
  `/dist/bootable.img` by launching a qemu virtual machine.
- `./x86_macos_boot.sh {image path}` - tests an bootable x86 qemu virtual
  machine image at the specified path. These are almost always images generated
  by the CI.

## In-Container Tools

These tools will refuse to run if they are not executed inside a container. To
start the container, run the following command at the root directory of the
mimux source tree:

```sh
docker-compose build && docker-compose up -d
```

- [./wipe.sh](./wipe.sh) - basically runs `./build clean` on every single package in the
  mimux source tree so that all builds run from scratch. However, it
  intentionally does not delete `./dist`.

- [./userspace.sh](./userspace.sh) - wrapper script that bootstraps all core userspace packages,
  sets permissions, and updates etc files.

- [./esp.sh](./esp.sh) - creates an efi filesystem image at `/dist/esp.img` that contains
  a linux kernel and the limine bootloader.
- [./rootimg.sh](./rootimg.sh) - creates an ext4 filesystem image at `/dist/rootfs.img` based
  on the files from `/dist/rootfs`
- [./bootable.sh](./bootable.sh) - creates a bootable image at `/dist/bootable.img` by running
  the above two scripts, then stitching them together.

- [./re_initramfs.sh](./re_initramfs.sh) and
  [./setup_initramfs.sh](./setup_initramfs.sh) - sets up a compressed initramfs
  image at `/dist/rootfs/boot/initramfs.cpio.gz`
- [./etc_update.sh](./etc_update.sh) - called by `./userspace.sh`. Basically an
  rsync wrapper to copy over the etc files in `/etc` to the rootfs.
