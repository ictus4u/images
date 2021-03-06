#!/bin/sh
set -e

image="${namespace:-minidocks}/maildev"
versions="
0.14;0.14.0
1.0;1.0.0
1.1;1.1.0
latest;1.1.0
"

build() {
    docker build $docker_opts --build-arg maildev_version="$2" -t "$image:$1" "$(dirname $0)"
}

case "$1" in
    --versions) echo "$versions" | awk 'NF' | cut -d';' -f1;;
    '') echo "$versions" | grep -v "^$" | while read -r version; do IFS=';'; build $version; done;;
    *) args="$(echo "$versions" | grep -E "^$1(;|$)")"; if [ -n "$args" ]; then IFS=';'; build $args; else echo "Version $1 does not exist." >/dev/stderr; exit 1; fi
esac
