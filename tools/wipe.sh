#!/bin/sh

set -eux

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR/.." || exit 1

for build in ./cross/build ./core/*/build ./init/*/build; do
  test -x "$build" && "$build" clear
done
