#!/bin/sh
set -x
set -e

if [ "$TARGET_ARCH" = "amd64-windows" ] ; then
  FILENAME="win"
elif [ "$TARGET_ARCH" = "armhf-linux" ] ; then
  FILENAME="ras"
else # TARGET_ARCH == amd64-linux
  FILENAME="lin"
fi
if [ "$BUILD_MODE" = "test" ] ; then
  chmod ugo+x ./build/release/"$FILENAME".exe # TODO : FIX ! this should not be needed !
  ./build/release/"$FILENAME".exe
else # BUILD_MODE == build

  mkdir -p build/release
  echo "ok $TARGET_ARCH $GITHUB_EVENT_NAME" > build/release/"$FILENAME".txt
  if [ "$FILENAME" = "lin" ] ; then
    cd build/release
    gcc -static ../../main.c -o "$FILENAME".exe
    strip "$FILENAME".exe
  elif [ "$FILENAME" = "ras" ] ; then
    cd build
    curl -L -k http://musl.cc/arm-linux-musleabihf-cross.tgz --output gcc.tgz
    tar -xzf gcc.tgz
    rm gcc.tgz
    cd release
    ../arm*/bin/arm*-gcc -static ../../main.c -o "$FILENAME".exe
    ../arm*/bin/arm*-strip "$FILENAME".exe
  else # FILENEME == win
    cd build
    curl -L -k http://musl.cc/i686-w64-mingw32-cross.tgz --output gcc.tgz
    tar -xzf gcc.tgz
    rm gcc.tgz
    cd release
    ../i686*/bin/i686*-gcc -static ../../main.c -o "$FILENAME".exe
    ../i686*/bin/i686*-strip "$FILENAME".exe
  fi
  chmod ugo+x "$FILENAME".exe
fi

