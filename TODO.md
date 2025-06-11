# TODO

(for whatever stupid reason, python refuses to compile on the CI)
- [P] Create CI Jobs to build both a rootfs tarball and the bootable :).
- [ ] Make some simple utilities for populating the kernel and limine
  bootloader on the esp?
- [P] Get a meta-build system working (that works inside the chroot). The
  core is supposed to be stupid for a reason. Package management should be more
  manual, but we should have a unified database for installed packages (just so
  we don't do something stupid).

- [ ] Build Perl (why is this so bad), best if perl can be put in core (because
  SOOOOO much stuff depends on it and the build for that is quite skibidi :/)
- [ ] Long-term Project: Get a GUI running with a browser
  - [ ] Firefox, Chromium, or something minimal with webkit?
  - [ ] Why are there soooo many dependencies ㅠㅠㅠ
