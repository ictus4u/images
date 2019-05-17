#!/bin/sh
set -e

image="${namespace:-minidocks}/texlive"
versions="
2018;2018;1
2018-basic;2018;1
2019;2019
2019-basic;2019
basic;2019
latest;2019
"

build() {
    docker build --build-arg historic="$3" --build-arg version="$2" -t "$image:$1" "$(dirname $0)"
}

case "$1" in
    --versions) echo "$versions" | awk 'NF' | cut -d';' -f1;;
    '') echo "$versions" | grep -v "^$" | while read -r version; do IFS=';'; build $version; done;;
    *) args="$(echo "$versions" | grep -E "^$1(;|$)")"; if [ -n "$args" ]; then IFS=';'; build $args; else echo "Version $1 does not exist." >/dev/stderr; exit 1; fi
esac
