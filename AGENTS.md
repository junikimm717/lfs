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
