# Mimux

![License](https://img.shields.io/github/license/junikimm717/lfs)

Named in memory of our cat Mimi (1/1/2022-5/13/2025). A complete system to
bootstrap a from-scratch Linux-based OS with complete toolchain and runtime
(musl libc, gcc, chrony, runit), packaging 30+ core utilities (busybox, openssl,
perl) into a <600 MB bootable image, supporting x86_64 and aarch64.

![Mimi](./mimi.jpg)

Development is standardized around the Alpine Linux Docker image defined in the
Dockerfile. For further documentation on the mimux build process, check out the
README's at [tools](./tools/) or [core](./core/).

I cannot believe I chose to undertake this project, but it's been quite
instructional and fun so far.

After two months of suffering, I also have personal beef against the perl build
system asdlfjas;lkdfjals;df (Also imagine goofy ahhh APFS not distinguishing
upper and lower case files names)


## Download (CI-Built)

All provided images here consist of a 2GB rootfs.

x86_64:

- [Bootable .img](https://github.com/junikimm717/lfs/releases/download/images/bootable-x86_64.img.gz)
- [rootfs tarball](https://github.com/junikimm717/lfs/releases/download/images/rootfs-x86_64.tar.gz)

aarch64:

- [Bootable .img](https://github.com/junikimm717/lfs/releases/download/images-aarch64/bootable-aarch64.img.gz)
- [rootfs tarball](https://github.com/junikimm717/lfs/releases/download/images-aarch64/rootfs-aarch64.tar.gz)

## Setup

The docker container is the *only* officially supported development environment
bc of tightly controlled dependencies and environment variables.

To launch into a dev shell, run `docker-compose up -d && ./tools/dev.sh`.

If you insist on a local environment (note COMPLETELY unsupported), install the
dependencies listed in `./Dockerfile` and then run

```sh
eval "$(./tools/env.sh)"
```

If a `build` script uses some random environment variable, it is almost
certainly defined in `./tools/env.sh`.

## Bootable Image Building

Execute the `./buildall.sh` with no arguments inside the dev container.
All final build artifacts will be located in `./dist/`.

On an M4 Pro Mac running Orbstack, this should take around 10 minutes to
complete. The GitHub CI takes around an hour to build each image.

## Version Checks

To ensure that packages with supported version checking are all up-to-date, you
should run the `./tools/versions.py` script.

## Virtual Machines

The kernel has been maximally stripped and has no module support. There is no
intention to support bare metal hardware.

If you're on Apple Silicon with Homebrew, congrats. Just run
`./tools/macos_boot.sh`; this should immediately boot up a working vm given you
installed qemu and efi firmware properly.

Otherwise, the setup is a big clunky, but here are some pointers for configuring
with something like Virt-manager, UTM, etc.

1. The bootable image is located in `./dist/bootable.img`
2. Select the options that allow you to directly import a disk
3. **YOU MUST USE UEFI**!! This may be slightly tricky, but make sure you have
   vm firmware installed for this. The reason this is enforced is because it is
   desired to have a consistent boot environment across all cpu architectures.

## Default OS Environment

The default user is `mimi` and the password is `george` (his favorite chipmunk).
Root login is disabled by default; you can perform root commands via `doas`.

Mimux uses musl, busybox, and runit (init scripts shamelessly ripped from void)
to reduce bloat. However, the intention is that there are sufficiently many
build tools that theoretically you can build most things from source.

The default timezone is US Eastern Time. To change, run
```sh
ln -sfn /usr/share/zoneinfo/{whatever} /etc/localtime
```
like you would for any other barebones distro.
