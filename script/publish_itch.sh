#!/bin/bash

SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
cd "$SCRIPT_DIR"

source config.sh

cd ../build

for BUILD_TARGET in $BUILDS; do
	BUILD=$(echo "$BUILD_TARGET" | cut -d: -f1)
	butler -i ../cred/itch.cred push $GAME-BUILD $ACCOUNT/$GAME:$BUILD --userversion-file $GAME-$BUILD/version.txt --dry-run
done
