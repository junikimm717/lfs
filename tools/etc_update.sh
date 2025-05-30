#!/bin/sh

# script that installs files in /etc (and maybe others)

# You MUST make sure that we are in a correct environment.
test -z "$INOSENV" && \
  echo "You cannot run this script while not in the juniosenv!" && \
  exit 1

DIR="$(realpath "$(dirname "$0" )" )/.."
DIR="$(realpath "$DIR" )"
