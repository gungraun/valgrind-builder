#!/bin/sh -ex
# spell-checker: ignore lbzip libc

sudo apt-get update && sudo apt-get install --assume-yes --no-install-recommends wget lbzip2 libc6-dbg
