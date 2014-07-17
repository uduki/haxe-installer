#!/bin/sh

#----------------------------#
#         Variables          #
#----------------------------#
NEKO_TMP=bin/neko
PREFIX=/usr/local
ARCHITECTURE="64" # "64" or "". "" is 32bit.
NEKO_VER="2.0.0"
NEKO_TAR="neko-$NEKO_VER-linux$ARCHITECTURE.tar.gz?id=download&cache=cache"
NEKO_URL="http://nekovm.org/_media/$NEKO_TAR"
NEKO_ARCHIVE_DIR="neko-$NEKO_VER-linux"

#----------------------------#
#       Install Neko         #
#----------------------------#
if [ ! -e ./neko.tar.gz ]; then
    wget $NEKO_URL -O neko.tar.gz
fi
mkdir -p $NEKO_TMP
tar zxvf neko.tar.gz -C $NEKO_TMP

if [ "$NEKO_ARCHIVE_DIR" != "" ]; then
    NEKO_TMP=$NEKO_TMP/$NEKO_ARCHIVE_DIR
fi

if [ ! -d $PREFIX/lib ]; then
    mkdir -p $PREFIX/lib
fi
cp $NEKO_TMP/libneko.so $PREFIX/lib

if [ ! -d $PREFIX/bin ]; then
    mkdir -p $PREFIX/bin
fi
cp $NEKO_TMP/neko $NEKO_TMP/nekoc $NEKO_TMP/nekotools $NEKO_TMP/nekoml $NEKO_TMP/nekoml.std $PREFIX/bin

if [ -e $PREFIX/lib/neko -a ! -d $PREFIX/lib/neko ]; then
    rm -f $PREFIX/lib/neko
fi

if [ ! -d $PREFIX/lib/neko ]; then
    mkdir $PREFIX/lib/neko
fi

cp $NEKO_TMP/*.ndll $PREFIX/lib/neko

#----------------------------#
#           Finish           #
#----------------------------#
cat <<EOF

#---------------------------------#

Done installing Neko.

#---------------------------------#

EOF
