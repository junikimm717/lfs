#!/bin/sh

set -eu

DIR="$(realpath "$(dirname "$0" )" )"

# The dev container already has the full cross-toolchain environment exported by
# tools/env.sh, so the build order must not re-derive a native one through coco.
DISABLE_COCO=1 exec "$DIR/../extra/apps/buildall"
