<!-- spell-checker: ignore libc memcheck gungraun -->

# valgrind-builder

Continuous builds of Valgrind for the GitHub CI and
[gungraun/setup-gungraun][setup-gungraun].

## Goals

The goal of this project is to provide builds for the most recent Valgrind
versions up to the latest 5 major/minor versions. The builds are meant for the
GitHub CI and kept minimal, simple and fast to install.

Valgrind is a \*nix only tool, so there won't be any builds for Windows.

## Installation

Installation: Download the tarball of a valgrind-builder release and extract it
in the root directory. Do not install somewhere else. Valgrind doesn't like it
to be installed in other places than the `--prefix` directory.

For example to install the valgrind-builder release (here `v3.27.0-1`) for
Valgrind `3.27.0` on a `ubuntu-24.04` runner in a github workflow

```yaml
- name: Download and install Valgrind
  run: |
      wget https://github.com/gungraun/valgrind-builder/releases/download/v3.27.0-1/valgrind-3.27.0-x86_64-ubuntu-24.04.tar.gz
      sudo tar xzf valgrind-3.27.0-x86_64-ubuntu-24.04.tar.gz -C /
      sudo apt-get update && sudo apt-get install --assume-yes --no-install-recommends libc6-dbg
```

On linux runners you also need to install the debug symbols for `libc` (in
debian based distributions the `libc6-dbg` package) or else Valgrind's
`memcheck` won't work.

## Build and tarball

A Valgrind version is selected for an OS if Valgrind can be build and run
without errors out of the box. Usually, it's best to use the latest Valgrind
version.

Other build details:

- No documentation included in the tarball to minimize the installation
- Valgrind is built with link time optimizations if possible to speed up
  Valgrind execution by up to 10%

Build table:

| OS      | OS version | available Valgrind versions                                  | install prefix | features         |
| ------- | ---------- | ------------------------------------------------------------ | -------------- | ---------------- |
| Ubuntu  | 22.04      | 3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br>3.27.0<br> | /usr           | lto, tls         |
| Ubuntu  | 24.04      | 3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br>3.27.0<br> | /usr           | lto, tls         |
| FreeBSD | 14.0       | 3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br>3.27.0<br> | /usr/local     | tls, 64-bit only |
| FreeBSD | 14.1       | 3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br>3.27.0<br> | /usr/local     | tls, 64-bit only |
| FreeBSD | 14.2       | 3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br>3.27.0<br> | /usr/local     | tls, 64-bit only |
| FreeBSD | 14.3       | 3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br>3.27.0<br> | /usr/local     | tls, 64-bit only |
| FreeBSD | 15.0       | 3.26.0<br>3.27.0                                             | /usr/local     | tls, 64-bit only |

[setup-gungraun]: https://github.com/gungraun/setup-gungraun
