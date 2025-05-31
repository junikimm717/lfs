#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR/.." || exit 1

./cross/build clear
for dr in ./core/*/; do
  test -x "$dr/build" && "$dr/build" clear
done || true
