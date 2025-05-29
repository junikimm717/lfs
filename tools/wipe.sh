#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR/.." || exit 1

./cross/build clear
for dr in ./pkgs/*/; do
  test -x "$dr/build" && "$dr/build" clear
done
find . -mindepth 2 -maxdepth 3 -name 'build' -type f -exec sh -c 'test -x {} && {} clear' \;
