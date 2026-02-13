# valgrind-builder

Continuous builds of valgrind intended for the ci to be minimal, simple and
fast.

## Installation

Download the tarball and unpack it in the root directory.

For example to install the latest valgrind-builder release with valgrind 3.26.0
on a ubuntu-24.04 runner in a github workflow

```yaml
- name: Download and install valgrind
  run:
    wget https://github.com/gungraun/valgrind-builder/releases/download/v0.1.0/valgrind-v0.1.0-ubuntu-24.04-3.26.0.tar.gz
    sudo tar xzf valgrind-v0.1.0-ubuntu-24.04-3.26.0.tar.gz -C /
```

## Build and tarball details

* No documentation included to minimize the installation
* Valgrind is built with link time optimizations to possibly speed up valgrind
  execution by around 10%
