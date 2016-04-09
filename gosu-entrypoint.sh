#!/bin/bash
# Author: Jonathan Meyer <jon@gisjedi.com>
# Source: https://github.com/gisjedi/gosu-entrypoint
# Version: master

set -e

# If GOSU_CHOWN environment variable set, recursively chown all specified directories 
# to match the user:group set in GOSU_USER environment variable.
if [ -n "$GOSU_CHOWN" ]; then
    for DIR in $GOSU_CHOWN
    do
        chown -R $GOSU_USER $DIR
    done
fi  

# If GOSU_USER environment variable set to something other than 0:0 (root:root),
# become user:group set within and exec command passed in args
if [ "$GOSU_USER" != "0:0" ]; then
    exec gosu $GOSU_USER "$@"
fi

# If GOSU_USER was 0:0 exec command passed in args without gosu (assume already root)
exec "$@"
