#!/bin/bash

SCRIPT_PATH=$(readlink -f "$0")
echo "Script path is $SCRIPT_PATH"
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
echo "SCRIPT_DIR is $SCRIPT_DIR"
cd "$SCRIPT_DIR"

source config.sh
echo "ACCOUNT is $ACCOUNT"
echo "GAME is $GAME"
echo "BUILDS are $BUILDS"

mkdir -p ../build
cd ../build

echo "Generating builds"
for BUILD_TARGET in $BUILDS; do
	echo "===$BUILD_TARGET==="
	BUILD=$(echo "$BUILD_TARGET" | cut -d: -f1)
	echo "$BUILD"
	BUILD_FILE=$(echo "$BUILD_TARGET" | cut -d: -f2)
	BUILD_DIR="$GAME-$BUILD"
	echo "$BUILD_FILE"
	mkdir -p "$BUILD_DIR"
	rm -rf "$BUILD_DIR/"*
	rm -rf "$BUILD_DIR.zip"
	godot --path ../godot --headless --export-release "$BUILD" "../build/$BUILD_DIR/$BUILD_FILE"
	cp -r ../license "$BUILD_DIR/"
	zip -r "$BUILD_DIR.zip" "$BUILD_DIR/"
done

