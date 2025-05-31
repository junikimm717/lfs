# Mimux

In Memory of Mimi (2022-5/13/2025)
![Mimi](./mimi.jpg)

This is **very much** WIP, but if you would like instructions, see
[setup.md](./setup.md). Development is standardized around the Alpine Linux
Docker image defined in the Dockerfile.

A lot of the init scripts were shamelessly ripped from Void Linux. Runit was
chosen as PID 1.

Goals:

1. Create a bootable image with a bootloader and all that
2. Have some (?) niceties on the system

Non-goals:

1. Get it to work on real hardware (I tried stripping down the kernel as much
   as possible, but this is maybe possible)

## To get the bootable image

Get into the container environment, then
```sh
# download the cross compilers
./cross/build all
# build the kernel FIRST
./core/kernel/build all
# set up the rootfs
./tools/setup_initramfs.sh # compiles initramfs-related things.
./tools/userspace.sh # installs userspace packages and also a user.

# create the bootable drive.
./tools/bootable.sh
```

## Default Environment

The default user is `mimi` and the password is `george` (his favorite chipmunk).

You should obviously change the root password if this is a real system (it's
probably not though)
