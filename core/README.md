# Mimux Core

This directory contains build scripts for all packages included in the bootstrap
mimux rootfs. It is preferred that this directory be kept as lean as possible to
reduce base installation size.

## New Packages

To add a new package to this build tree, `cd` into this directory
and then run the following script:

```sh
../tools/pkg.sh {package}
```

You should also insert a new entry in `../tools/userspace.sh` with the following
line (the build function is also defined at the top and is dead simple):

```sh
build {package}
```

This should create a directory called `{package}` with a pre-filled `build`
script that can be filled out to fit your package's build process.

## The Build Script

The mimux core build process is designed for both standardization and maximum
flexibility. All package builds are based on a standalone, working-directory
agnostic `./build` script that can be arbitrarily hacked.

All `build` scripts currently in the source tree have four main functions:

1. download - downloads the source tarball. By precedent, the source tarball
  should be downloaded into `{package}/`.
2. extract - extracts the tarball, may apply some patches, and maybe runs
   `./configure`. You may add any additional patches into the 
3. makeinstall - generally just runs `make && make install`, although can easily
   accommodate additional steps as required.
4. clear - removes all build artifacts in the `{package}` dir. This is nice for
   when you want to do clean builds/test whether build processes work correctly.

## Executing the build script

All build scripts must be run inside the provided dev container. No other
environment is supported.

In generally, you will run two main commands:

```sh
# here, we run scripts from the root of the mimux repository to illustrate the
# fact that the build script is working directory agnostic.
./core/{package}/build all # runs the download, extract, and makeinstall functions in succession
./core/{package}/build clear # clear all build artifacts.
```

## Versioning

Some package directories will contain a `version` script. This script is
intended to have one task; output the latest stable version. This `version`
script must be accompanied by a `$VERSION` variable declaration in the
`build` script.

For example, take a look at the version script for curl:

```bash
curl https://api.github.com/repos/curl/curl/tags 2> /dev/null \
  | jq -r '.[].name' \
  | grep -E '^curl-[0-9,\_]+$' \
  | head -n 1 \
  | sed -e "s/^curl-\(.*\)$/\1/g" \
  | tr '_' '.'
```

And the definition in the `build` script:

```bash
# the important variable. Notice how $VERSION acts as a single source of truth.
VERSION="8.14.0"
TAG="curl-$(echo $VERSION | tr '.' '_')"
BASEURL="https://github.com/curl/curl/releases/download/$TAG"
SRCDIR="curl-$VERSION"
TARBALL="$SRCDIR.tar.xz"
```

**Important**: The `$VERSION` declaration must be done in **double quotes** as
shown above. This is so that the extremely stupid regex used in
`/tools/versions.py` (used to check whether all packages are actually
up-to-date) can extract the version numbers correctly :).

### Dev.mit.junic.kim??

This is a VPS hosted by Juni, the creator of Mimux, that contains tarballs for
select tarballs for which the download process is occasionally unstable. It also
hosts the musl toolchains used to bootstrap Mimux.

I have been able to eliminate dependence on dev.mit.junic.kim for all packages
in core by moving to mirrors. Using self-hosted tarballs is not usually desired
since updating these package versions requires manually updating the
dev.mit.junic.kim mirror to include those tarballs.

Currently, the only package using dev.mit.junic.kim is my custom cross compiling
toolchain (ripped from
[static-python](https://github.com/junikimm717/static-python)).

### Manual Version Management

The packages that currently do not have version scripts attached (and therefore
require manually checking for updates) are:

- `certs` - certificates get continually updated, a script called `update-cacert`
  is also provided within the mimux env.
- `perl` - I have yet to figure how to package perl reliably across different
  versions. The current packaging system only works for 5.40.2 because we inject
  a version-specific Makefile.

## Environment Variables

The tight coupling between the build script and the dev container means many
environment variables can be provided for convenience. These should be used instead
of hardcoding any paths.

- `$ROOTFS` - The root directory of the rootfs that is getting constructed.
- `$JOBS` - The number of processes that the build process should spawn. Almost
  always used as `make -j${JOBS:-8}`. `JOBS` is usually configured as some
  number slightly less than `$(nproc)`.
- `$TARGET` - Either `x86_64-linux-musl` or `aarch64-linux-musl`; matches the
  target operating system. Cross-architecture compilation is currently NOT
  supported because taming like 30 packages will be an absolute nightmare.

However, as visible in `./kernel/build`, `./perl/build`, or `./python3/build`,
you are free to change other given environment variables such as `$CFLAGS`,
`$CPPFLAGS`, `$LD_LIBRARY_PATH`, etc. to get the build system working correctly.

## Convenience Variables

The starter code for the build script will have a header that looks like this:

```sh
DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR"

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && {
  echo "You cannot run this script while not in the mimuxenv!" && \
  exit 1;
}

VERSION="3.13.3"
BASEURL="https://www.python.org/ftp/python/$VERSION"
SRCDIR="Python-$VERSION"
TARBALL="$SRCDIR.tar.xz"
```

VERSION, BASEURL, SRCDIR, and TARBALL are convenience variables defined on the
spot for you to modify as appropriate. They reflect the fact that for most
regular packages, the build process starts by grabbing a tarball from GitHub or
some other mirror.

`$SRCDIR` is the name of the directory that should pop out when you run `tar xf
$TARBALL`.

If, for whatever stupid reason, the tarball just spews its build contents out
into `/core/{package}` directly, just modify the build script to `mkdir -p
$SRCDIR && cd $SRCDIR && tar xf ../$TARBALL`.
