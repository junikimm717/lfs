# Mimux


![Mimux Core](https://img.shields.io/endpoint?url=https%3A%2F%2Fmxm.mit.junic.kim%2Fbadge)
![License](https://img.shields.io/github/license/junikimm717/lfs)
[![aarch64 Images](https://github.com/junikimm717/lfs/actions/workflows/build_aarch64.yml/badge.svg)](https://github.com/junikimm717/lfs/actions/workflows/build_aarch64.yml)
[![x86 Images](https://github.com/junikimm717/lfs/actions/workflows/build_x86.yml/badge.svg)](https://github.com/junikimm717/lfs/actions/workflows/build_x86.yml)

Named in memory of our cat Mimi (1/1/2022-5/13/2025).
Bootstrapping a from-scratch Linux-based OS with complete toolchain and runtime
(musl libc, gcc, chrony, runit), manually packaging 30+ core utilities (busybox,
openssl, perl) into a <600 MB bootable image, supporting x86_64 and aarch64.

Mimux aims to be up-to-date with its core packages as possible. Packages are
kept up-to-date with the latest stable release. Statuses are publicly available
at [mxm.mit.junic.kim](https://mxm.mit.junic.kim)

![Mimi](./mimi.jpg)

Development is standardized around the Alpine Linux Docker image defined in the
Dockerfile. For further documentation on the Mimux build process, check out the
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

## Default OS Environment

The default configured bootloader will supply you with three boot modes:

1. *Mimux \$kernel* - Normal booting, normal init runs and you get dropped into a
   getty session
2. *Mimux \$kernel (logs)* - Same as above, except that kernel and init logs
   will be visible in the same tty where you log in.
3. *Mimux \$kernel (debug shell)* - You get dropped into an initramfs shell.

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

Below are some mimux-specific scripts provided for convenience:

- `update-cacert` - an extremely simple wrapper to update the CA certificates
  store from curl.se
- `mimux-test` - a wrapper to execute all test programs stored in `/usr/test`.
  These are mostly sanity checks on python and perl.

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

## Virtual Machines

The kernel has been maximally stripped and has no module support. There is no
intention to support bare metal hardware.

If you're on Apple Silicon with Homebrew, congrats. Just run
`./tools/macos_boot.sh`; this should immediately boot up a working vm given you
installed qemu and efi firmware in the standard homebrew way.

Otherwise, the setup is a big clunky, but here are some pointers for configuring
with something like Virt-manager, UTM, etc.

1. The bootable image is located in `./dist/bootable.img`
2. Select the options that allow you to directly import a disk
3. **YOU MUST USE UEFI**!! This may be slightly tricky, but make sure you have
   vm firmware installed for this. This is enforced because I want a consistent
   boot environment across all cpu architectures.

## Version Checks

To ensure that packages with supported version checking are all up-to-date, you
should run the `./tools/versions.py` script. This script gets automatically run
by the CI on each commit as well.

Since build scripts may be incompatible across different package
versions/require tweaking to run, actual package bumps will be done manually.
