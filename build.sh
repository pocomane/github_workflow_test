#!/bin/sh
set -x
set -e

if [ "$TARGET_ARCH" = "amd64-windows" ] ; then
  FILENAME="win"
else # TARGET_ARCH == amd64-linux
  FILENAME="lin"
fi
if [ "$BUILD_MODE" = "test" ] ; then
  ./build/release/"$FILENAME".exe
else # BUILD_MODE == build

  mkdir -p build/release
  cd build/release
  echo "ok $TARGET_ARCH $GITHUB_EVENT_NAME" > "$FILENAME".txt
  # if [ "$FILENAME" = "lin" ] ; then
    gcc -static ../../main.c -o  "$FILENAME".exe
  # else # FILENEME == win
  #   gcc -static ../../main.c -o  "$FILENAME".exe
  # fi
fi

