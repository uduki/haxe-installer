#!/bin/sh

#----------------------------#
#         Variables          #
#----------------------------#
HAXE_TMP=bin
PREFIX=/usr/local
ARCHITECTURE="64" # "64" or "". "" is 32bit.
HAXE_VER="3.1.3"
HAXE_TAR="haxe-$HAXE_VER-linux$ARCHITECTURE.tar.gz"
HAXE_URL="http://haxe.org/file/$HAXE_TAR" # new? -> http://haxe.org/download/file/$HAXE_VER/$HAXE_TAR
HAXE_ARCHIVE_DIR="haxe-$HAXE_VER"

#----------------------------#
#       Install Haxe         #
#----------------------------#
if [ ! -e $HAXE_TAR ]; then
    wget $HAXE_URL
fi
mkdir -p $HAXE_TMP
tar zxvf $HAXE_TAR -C $HAXE_TMP

if [ -e $PREFIX/bin/haxe ]; then
    rm -f $PREFIX/bin/haxe
fi

if [ -e $PREFIX/bin/haxelib ]; then
    rm -f $PREFIX/bin/haxelib
fi

if [ ! -d $PREFIX/bin ]; then
    mkdir -p $PREFIX/bin
fi

cp $HAXE_TMP/$HAXE_ARCHIVE_DIR/haxe $PREFIX/bin/haxe
cp $HAXE_TMP/$HAXE_ARCHIVE_DIR/haxelib $PREFIX/bin/haxelib

if [ -e $PREFIX/lib/haxe ]; then
    rm -rf $PREFIX/lib/haxe
fi

mkdir -p $PREFIX/lib/haxe/lib
chmod 777 $PREFIX/lib/haxe/lib
cp -r $HAXE_TMP/$HAXE_ARCHIVE_DIR/std $PREFIX/lib/haxe

#----------------------------#
#      Setup Haxe lib        #
#----------------------------#
cat <<EOF

#---------------------------------#

Done installing Haxe.
Please run the following commands.
    # su
    # ldconfig
    # haxelib setup

    Note: Path is $PREFIX/lib/haxe/lib

#---------------------------------#

EOF
