<!-- spell-checker: ignore libc memcheck -->

# valgrind-builder

Continuous builds of valgrind intended for the ci to be minimal, simple and fast
to install.

## Installation

valgrind is a \*nix only tool, so there are no builds for any other OS. FreeBSD
is currently included in the builds because github actions like
`https://github.com/cross-platform-actions/action` are available to run freebsd
with almost native speed on an ubuntu runner.

Installation is simple: Download the tarball of a valgrind-builder release and
extract it in the root directory. Do not install somewhere else. Valgrind
doesn't like it to be installed in other places than the `--prefix` directory.

For example to install the valgrind-builder release (here `v0.1.0`) for valgrind
`3.26.0` on a `ubuntu-24.04` runner in a github workflow

```yaml
- name: Download and install valgrind
  run: |
      wget https://github.com/gungraun/valgrind-builder/releases/download/v0.1.0/valgrind-3.26.0-x86_64-ubuntu-24.04.tar.gz
      sudo tar xzf valgrind-3.26.0-x86_64-ubuntu-24.04.tar.gz -C /
      sudo apt-get update && sudo apt-get install --assume-yes --no-install-recommends libc6-dbg
```

On linux runners you also need to install the `libc6-dbg` package or else
valgrind's `memcheck` won't work.

## Build and tarball

A valgrind version is selected for an os if valgrind can be build and run
without errors out of the box. Usually, it's best to use the latest valgrind
version.

Other build details:

- No documentation included in the tarball to minimize the installation
- Valgrind is built with link time optimizations if possible to speed up
  valgrind execution by up to 10%

Build table:

| OS      | OS version | available valgrind versions                                                                | install prefix | features         |
| ------- | ---------- | ------------------------------------------------------------------------------------------ | -------------- | ---------------- |
| Ubuntu  | 22.04      | 3.19.0<br>3.20.0<br>3.21.0<br>3.22.0<br>3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br> | /usr           | lto, tls         |
| Ubuntu  | 24.04      | 3.19.0<br>3.20.0<br>3.21.0<br>3.22.0<br>3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br> | /usr           | lto, tls         |
| FreeBSD | 14.0       | 3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br>                                         | /usr/local     | tls, 64-bit only |
| FreeBSD | 14.1       | 3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br>                                         | /usr/local     | tls, 64-bit only |
| FreeBSD | 14.2       | 3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br>                                         | /usr/local     | tls, 64-bit only |
| FreeBSD | 14.3       | 3.23.0<br>3.24.0<br>3.25.0<br>3.25.1<br>3.26.0<br>                                         | /usr/local     | tls, 64-bit only |
| FreeBSD | 15.0       | 3.26.0                                                                                     | /usr/local     | tls, 64-bit only |
