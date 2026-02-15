#!/bin/sh -eux
# spell-checker: ignore autogen ncpu ncpus destdir lbzip libc cflags flto

VALGRIND_VERSION="${1:-3.26.0}"
OS="${2:-linux}"
BUILD_DIR="$(pwd)/build"

configure_args="--enable-tls"
case "$OS" in
linux)
  ncpus=$(nproc)
  make="make"
  configure_args="${configure_args} --prefix=/usr"
  ;;
freebsd)
  ncpus=$(sysctl -n hw.ncpu)
  make="gmake"
  configure_args="${configure_args} --prefix=/usr/local --enable-only64bit"
  ;;
*)
  echo "Unknown OS: ${OS}"
  exit 1
  ;;
esac

mkdir -p "${BUILD_DIR}"

cd "${BUILD_DIR}"
wget https://sourceware.org/pub/valgrind/valgrind-"${VALGRIND_VERSION}".tar.bz2
tar xf valgrind-"${VALGRIND_VERSION}".tar.bz2

cd valgrind-"${VALGRIND_VERSION}"

./autogen.sh
# shellcheck disable=SC2086
./configure $configure_args

"$make" -j"${ncpus}" BUILD_DOCS=none
