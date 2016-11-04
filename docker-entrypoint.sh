#!/bin/bash
set -eo pipefail

mkdir bin lib lib64 run sbin sys tmp usr var
mount -o bind /bin bin
mount -o bind /lib lib
mount -o bind /lib64 lib64
mount -o bind /run run
mount -o bind /sbin sbin
mount -o bind /sys sys
mount -o bind /tmp tmp
mount -o bind /usr usr
mount -o bind /var var

# Run command.
exec "$@"
