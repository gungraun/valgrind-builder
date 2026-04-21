#!/bin/sh -eux
# spell-checker: ignore autogen ncpu ncpus destdir lbzip libc cflags flto

VALGRIND_VERSION="${1:-3.27.0}"
OS="${2:-linux}"
BUILD_DIR="$(pwd)/build"

asset="valgrind-${VALGRIND_VERSION}.tar.bz2"
configure_args="--enable-tls"
case "$OS" in
linux)
  ncpus=$(nproc)
  make="make"
  sha="sha512sum"
  configure_args="${configure_args} --prefix=/usr"
  ;;
freebsd)
  ncpus=$(sysctl -n hw.ncpu)
  make="gmake"
  sha="$(command -v sha512sum)"
  configure_args="${configure_args} --prefix=/usr/local --enable-only64bit"
  ;;
*)
  echo "Unknown OS: ${OS}"
  exit 1
  ;;
esac

mkdir -p "${BUILD_DIR}"

cd "${BUILD_DIR}"
wget "https://sourceware.org/pub/valgrind/${asset}"
wget "https://sourceware.org/pub/valgrind/sha512.sum"
$sha -c sha512.sum --ignore-missing | grep "^${asset}\s*:\s*OK"

tar xf valgrind-"${VALGRIND_VERSION}".tar.bz2

cd valgrind-"${VALGRIND_VERSION}"

./autogen.sh
# shellcheck disable=SC2086
./configure $configure_args

"$make" -j"${ncpus}" BUILD_DOCS=none
