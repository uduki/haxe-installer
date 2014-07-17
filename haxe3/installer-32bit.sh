#!/bin/sh

#----------------------------#
#         Variables          #
#----------------------------#
HAXE_TMP=bin/haxe
NEKO_TMP=bin/neko
PREFIX=/usr/local
HAXE_VER="3.1.3"
HAXE_URL="http://haxe.org/file/haxe-$HAXE_VER-linux32.tar.gz"
HAXE_TAR="haxe-$HAXE_VER-linux32.tar.gz"
HAXE_ARCHIVE_DIR="build"
NEKO_VER="2.0.0"
NEKO_URL="http://nekovm.org/_media/neko-$NEKO_VER-linux.tar.gz?id=download&cache=cache"
NEKO_TAR="neko-$NEKO_VER-linux.tar.gz?id=download&cache=cache"
NEKO_ARCHIVE_DIR="neko-$NEKO_VER-linux"


#----------------------------#
#       Install Haxe         #
#----------------------------#
if [ ! -e $HAXE_TAR ]; then
    wget $HAXE_URL
fi
mkdir -p $HAXE_TMP
tar zxvf $HAXE_TAR -C $HAXE_TMP

if [ "$HAXE_ARCHIVE_DIR" != "" ]; then
    HAXE_TMP=$HAXE_TMP/$HAXE_ARCHIVE_DIR
fi

if [ -e $PREFIX/bin/haxe ]; then
    sudo rm -f $PREFIX/bin/haxe
fi

sudo cp $HAXE_TMP/haxe $PREFIX/bin/haxe

if [ -e $PREFIX/lib/haxe ]; then
    sudo rm -rf $PREFIX/lib/haxe
fi

sudo mkdir -p $PREFIX/lib/haxe/lib
sudo chmod 777 $PREFIX/lib/haxe/lib
sudo cp -r $HAXE_TMP/std $PREFIX/lib/haxe
sudo cp $HAXE_TMP/std/tools/haxelib/haxelib.sh $PREFIX/bin/haxelib
sudo chmod +x $PREFIX/bin/haxelib


#----------------------------#
#       Install Neko         #
#----------------------------#
if [ ! -e $NEKO_TAR ]; then
    wget $NEKO_URL
fi
mkdir -p $NEKO_TMP
tar zxvf $NEKO_TAR -C $NEKO_TMP

if [ "$NEKO_ARCHIVE_DIR" != "" ]; then
    NEKO_TMP=$NEKO_TMP/$NEKO_ARCHIVE_DIR
fi

sudo cp $NEKO_TMP/libneko.so $PREFIX/lib
sudo cp $NEKO_TMP/neko $NEKO_TMP/nekoc $NEKO_TMP/nekotools $NEKO_TMP/nekoml $NEKO_TMP/nekoml.std $PREFIX/bin

if [ -e $PREFIX/lib/neko -a ! -d $PREFIX/lib/neko ]; then
    sudo rm -f $PREFIX/lib/neko
fi

if [ ! -d $PREFIX/lib/neko ]; then
    sudo mkdir $PREFIX/lib/neko
fi

sudo cp $NEKO_TMP/*.ndll $PREFIX/lib/neko


#----------------------------#
#      Setup Haxe lib        #
#----------------------------#

cat <<EOF

#---------------------------------#

Done Haxe and Neko install.
Please run the following commands.
    # su
    # ldconfig
    # haxelib setup

    Note: Path is $PREFIX/lib/haxe/lib

#---------------------------------#

EOF
