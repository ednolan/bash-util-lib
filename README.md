# bash-util-lib

Contains bash files which define useful utility functions. Scripts can read in the definitions with `source`/`.`.

## bash-util-lib-log.sh

These functions timestamp the provided message, tag it with the specified log level, and log to stderr.

## bash-util-lib-check.sh

Functions used to verify that a script can be run successfully by the system that's currently executing it.

## bash-util-lib-persistent-map.sh

Wraps `jq` to provide a simple interface for manipulating a file containing a non-nested JSON object with string keys and values.
