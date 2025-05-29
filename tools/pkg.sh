#!/bin/sh

DIR="$(realpath "$(dirname "$0" )" )"

test -z "$1" && {
  echo "pkg.sh requires at least one argument for a package.";
  exit 1;
}

test -e "$1" && {
  echo "The package cannot already exist";
  exit 1;
}

NAME="$(basename "$1")"
mkdir "$1"
cd "$1" || exit 1

sed "s/PACKAGE/$NAME/g" "$DIR/../misc/build.template" > "build" && chmod +x build
echo "$NAME-*" > ".gitignore"
