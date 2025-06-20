# Mimux

In Memory of Mimi (1/1/2022-5/13/2025). A hobby Linux "distribution" supporting
x86_64 and aarch64.

![Mimi](./mimi.jpg)

This is **very much** WIP and is absolutely NOT ready for use unless you wish to
contribute. Development is standardized around the Alpine Linux Docker image
defined in the Dockerfile.

## Setup

You must first activate the working environment by running the following command
in your shell:

```sh
eval "$(./tools/env.sh)"
```

Or just run `docker-compose up -d && ./tools/dev.sh`.
In particular, the container is the *only* supported development environment.

## Bootable Image Building

Get into the container environment (as describe above), then
```sh
./buildall.sh
```

On an M4 Mac running orbstack, this should take around 10 minutes to complete.

Hopefully I can get some nice CI jobs for these :)

## Virtual Machines

If you're on Apple Silicon with Homebrew, congrats. Just run
`./tools/macos_boot.sh`; this should just work given you installed qemu and efi
firmware properly.

Otherwise, the setup is a big clunky, but here are some pointers for configuring
with something like Virt-manager, UTM, etc.

1. The bootable image is located in `./dist/bootable.img`
2. Select the options that allow you to directly import a disk
3. **YOU MUST USE UEFI**!! This may be slightly tricky, but make sure you have
   vm firmware installed for this.

## Default OS Environment

The default user is `mimi` and the password is `george` (his favorite chipmunk).
Root login is disabled by default; you can do arbitrary commands via `doas`.

Mimux uses musl, busybox, and runit to reduce bloat, but you should have many of
your standard build tools installed on the system. Many of the runit init
scripts were shamelessly ripped from Void :)
