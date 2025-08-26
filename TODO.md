# TODO

- [ ] Make some simple utilities for populating the kernel and limine
  bootloader on the esp?
- [P] Get a meta-build system working (that works inside the chroot). The
  core is supposed to be stupid for a reason. Package management should be more
  manual, but we should have a unified database for installed packages (just so
  we don't do something stupid).

- [ ] Make ACTUAL TESTS!!! Like surely it is important to make sure the
  operating system is actually functional.

- [ ] Figure out cross-compilation (can we do this?? hmm...)
- [ ] Rewrite the init system in go (statically linked)?? hmm...

- [ ] Long-term Project: Get a GUI running with a browser
  - [ ] Firefox, Chromium, or something minimal with webkit?
  - [ ] Why are there soooo many dependencies ahhhhh
