#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"
cd "$DIR/.." || exit 1

find . -mindepth 2 -maxdepth 3 -name 'build' -type f -exec sh -c 'test -x {} && {} clear' \;
