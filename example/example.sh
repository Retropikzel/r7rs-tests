#!/bin/sh
set -eu
cd "$(dirname "$0")"
set -x
chibi-scheme -I . -e '(import (example))'
