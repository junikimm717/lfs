# Juni's Linux from Scratch

Just another deranged attempt at a Linux From Scratch, except not going by the
book. This is **very much** WIP, but if you would like instructions, see
[setup.md](./setup.md). Development is standardized around the alpine docker
image defined in the Dockerfile.

A lot of the init scripts were shamelessly ripped from Void Linux :)

Goals:

1. Create a bootable image with a bootloader and all that
2. Have some (?) niceties on the system

Non-goals:

1. Get it to work on real hardware (I tried stripping down the kernel as much
   as possible, but this is maybe possible)
