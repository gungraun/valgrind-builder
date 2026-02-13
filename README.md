# valgrind-builder

Continuous builds of valgrind intended for the ci to be minimal, simple and
fast.

## Installation

Download the tarball and unpack it in the root directory. For example to install
ehe latest valgrind 3.26.0 on a ubuntu-24.04 runner in a github workflow

```yaml
- name: Download and install valgrind
  run:
    wget TODO
    sudo tar xzf TODO -C /
```

## Build details

* No documentation in the tarball
* Built with lto to speed up valgrind execution by 10%
