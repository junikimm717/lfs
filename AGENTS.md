# Mimux

This is the repository of `mimux`, an automated LFS build system. Goal is
generally to fit most dev tools in a small size.

## Development Guidelines

Consult the [README](./README.md) for more details, as well as the README's in
each of the repository folders. You are expected to perform all operations
through a docker container, as we built the build process to be specific to
that. In the container (at least on Linux), you are PID 0, so attempting to
delete artifacts outside of that may lead to strange permission errors.

For any long-running jobs (e.g. compiling software, which will be a huge chunk
of this process), you are expected to use tmux (if it exists on your system).
By spawning tmux sessions, you give the user greater visibility into what the
system is doing.

You should strive for reproducibility of the build scripts, as they run in CI
without a cache. You may write ad-hoc fixes for troubleshooting, but they
should never be in the final build unless they're crucial.

When invoking build scripts, you should ensure that they are running with a
reasonable number of jobs, but not so much that we starve other processes from
CPU time. You can probably get up to 80-90% of the number of cores.

## Testing/debugging via SSH

The core image ships `dropbear` (see `core/dropbear/`) and the QEMU boot
scripts (`tools/macos_boot.sh`, `tools/x86_macos_boot.sh`,
`tools/linux_boot.sh`) forward host `:2222` to guest `:22`, so a booted VM can
be driven and diagnosed over `ssh -p 2222 mimi@localhost` instead of manual
console interaction or screenshots. Login is `mimi`/`george`; root login is
disabled.

- Before regenerating `bootable.img`/`rootfs.img` (`tools/rootimg.sh`,
  `tools/bootable.sh`), always kill any QEMU instance that still has the old
  image open first. Rebuilding the disk image out from under a live QEMU
  process is a real corruption risk, not just messy.
- Kill the VM process when you're done with it -- don't leave stray
  `qemu-system-*` processes (and the port-2222 listener) running past the end
  of a debugging session.
- `scp`/`sftp` aren't available (no `sftp-server` shipped); use
  `ssh ... 'cat > file' < localfile` to push files instead.
- (If debugging Xorg related issues) Setuid `Xorg` refuses `-logfile`/`-config`
  with absolute paths when running with elevated privileges; write to the default
  log path (`/usr/var/log/Xorg.0.log`) or edit `/etc/X11/xorg.conf.d/*.conf`
  directly.
