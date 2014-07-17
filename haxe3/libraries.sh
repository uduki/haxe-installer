#!/bin/sh

#----------------------------#
#         Variables          #
#----------------------------#
ENABLE_GUI_LIBS="yes" # "yes" or "no"
ENABLE_JQUERY_LIBS="yes" # "yes" or "no"

function header()
{
    cat <<EOF
#----------------------------#
# $1
#----------------------------#
EOF
}

#----------------------------#
#   Install gui libraries    #
#----------------------------#
if [ "$ENABLE_GUI_LIBS" == "yes" ]; then
    header "Install lime"
    haxelib install lime
    haxelib run lime setup

    header "Install OpenFL"
    haxelib install openfl

    header "OpenFL setup android"
    lime setup android

    header "Install actuate"
    haxelib install actuate

    header "Install HaxeUI"
    haxelib install haxeui

    header "Install StablexUI"
    haxelib install stablexui
fi

if [ "$ENABLE_JQUERY_LIBS" == "yes" ]; then
    header "Install jQueryExtern"
    haxelib install jQueryExtern
fi
