#!/bin/sh -ex
# spell-checker: ignore autogen ncpus destdir lbzip libc

VALGRIND_VERSION="${1:-3.26.0}"
BUILD_DIR="$(pwd)/build"
DESTDIR="${BUILD_DIR}/root"

mkdir -p "${BUILD_DIR}" "${DESTDIR}"

cd "${BUILD_DIR}"
wget https://sourceware.org/pub/valgrind/valgrind-"${VALGRIND_VERSION}".tar.bz2
tar xf valgrind-"${VALGRIND_VERSION}".tar.bz2

cd valgrind-"${VALGRIND_VERSION}"

./autogen.sh
./configure --prefix=/usr --enable-lto

ncpus=$(nproc)
make -j"${ncpus}" BUILD_DOCS=none
