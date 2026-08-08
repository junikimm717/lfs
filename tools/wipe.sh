#!/bin/sh

set -eux

# Wipe every out-of-tree build tree and the shared tarball cache. Both live
# under $BUILDDIR / $TARBALLS (default dist/build, dist/cache); the `:?` guards
# ensure we never `rm -rf` an empty path if the mimuxenv isn't active.
rm -rf "${BUILDDIR:?set BUILDDIR -- run inside the mimuxenv}"
rm -rf "${TARBALLS:?set TARBALLS -- run inside the mimuxenv}"
