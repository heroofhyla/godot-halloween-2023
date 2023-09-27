#!/bin/bash

SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
cd "$SCRIPT_DIR"

source config.sh

mkdir -p ../build
cd ../build

git describe > ../version.txt

echo "Generating builds"
for BUILD_TARGET in $BUILDS; do
	echo "===$BUILD_TARGET==="
	BUILD=$(echo "$BUILD_TARGET" | cut -d: -f1)
	echo "$BUILD"
	BUILD_FILE=$(echo "$BUILD_TARGET" | cut -d: -f2)
	BUILD_DIR="$GAME-$BUILD"
	echo "$BUILD_FILE"
	mkdir -p "$BUILD_DIR"
	rm -rf "$BUILD_DIR"/*
	rm -rf "$BUILD_DIR.zip"
	godot --path ../godot --headless --export-release "$BUILD" "../build/$BUILD_DIR/$BUILD_FILE"
	cp -r ../license "$BUILD_DIR/"
	cp ../version.txt "$BUILD_DIR/"
	zip -r "$BUILD_DIR.zip" "$BUILD_DIR/"
done

