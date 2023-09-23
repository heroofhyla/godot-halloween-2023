#!/bin/bash

SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
cd "$SCRIPT_DIR"

source config.sh

mkdir -p ../build
cd ../build

for BUILD_TARGET in $BUILDS; do
	BUILD=$(echo "$BUILD_TARGET" | cut -d: -f1)
	BUILD_FILE=$(echo "$BUILD_TARGET" | cut -d: -f2)
	mkdir -p "$BUILD_DIR"
	rm -rf "$BUILD_DIR/"*
	rm -rf "$BUILD_DIR.zip"
	godot --path ../godot --headless --export-release "$BUILD" "../build/$BUILD_DIR/$BUILD_FILE"
	zip -r "$BUILD_DIR.zip" "$BUILD_DIR/"
done

