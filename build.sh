#!/bin/sh
set -x
set -e
if [ "$BUILD_MODE" = "build" ] ; then
  mkdir -p build/release
  cd build/release
  FILENAME="lin.txt"
  if [ "$TARGET_ARCH" = "amd64-windows" ] ; then
    FILENAME="win.txt"
  fi
  echo "ok $TARGET_ARCH $GITHUB_EVENT_NAME" > "$FILENAME"
else # BUILD_MODE == test
  echo "ok"
fi
