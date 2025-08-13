FROM alpine

# Extremely basic dockerfile for dev purposes.

RUN apk add --no-cache\
  git make curl tar perl meson ninja unzip openssl-dev openssl\
  xz flex bison ncurses-dev ncurses-libs ncurses rsync\
  e2fsprogs e2fsprogs-extra fakeroot \
  binutils file make patch \
  bash zstd findutils gcc musl-libintl musl-dev g++ gperf cmake\
  automake autoconf m4 parted lsblk e2tools sgdisk libtool \
  gmp-dev mpc1-dev mpfr-dev mtools libelf elfutils-dev linux-headers nasm\
  tzdata-utils coreutils python3 bash jq

WORKDIR /workspace
