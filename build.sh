#!/usr/bin/env bash
set -e

if [ -n "$1" ]; then
    echo Updating version tag to $1
    sed -i "s/master/$1/g" gosu-entrypoint.sh
fi

