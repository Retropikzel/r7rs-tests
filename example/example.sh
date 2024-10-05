#!/bin/sh
set -eu
cd "$(dirname "$0")"
set -x

# Chibi
chibi-scheme -I . -e '(import (example))'

# Gambit
gsi-script . -e '(import (example))'

# Gauche
gosh -I . example.sld -e '(import (example))' -e '(exit)'
