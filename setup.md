# Setup

You must first activate the working environment by running the following command
in your shell:

```sh
eval "$(./tools/env.sh)"
```

Or just run `docker-compose up -d && ./tools/dev.sh`

Most things are optimized to work with the container, so that is the recommended
option. The container **needs** to be privileged to run the image building
scripts (which involve some loop device hacks).

# Initramfs

run `./tools/setup_initramfs.sh`. If you make any changes to the initramfs, run
`./tools/re_initramfs.sh` after your change.

The script also sets up kernel headers, modules, and a cut down busybox utility
(statically linked)

It turns out that the kernel just panics if you don't have a `/init` script in
your initramfs, even if `/sbin/init` already exists 🤡.

# Rootfs

Set up userspace packages by running `./tools/userspace.sh`, and configure /etc
and friends by running `./tools/etc.sh`.

Then, refresh the rootfs image by running `./tools/cr_rootimg.sh`

# Emulator

Just use the `./tools/emulator.sh` script to get rolling, either on the
container or on your main system.
