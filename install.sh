#!/bin/bash

DOTS=(
    alacritty
    bspwm
    polybar
    sxhkd
    xsettingsd
)

SOURCE_PATH="./"
DEST_PATH="${HOME}/iDotfiles/.config/"

function copy_dot {
    dot=$1
    echo "Copying ${dot} dotfile ..."
    cp -RT "${SOURCE_PATH}${dot}/" "${DEST_PATH}${dot}/"
}

function create_backup {
    dot=$1
    echo "Creating ${dot} backup ..."
    mv "${DEST_PATH}${dot}/" "${DEST_PATH}${dot}_backup"
}

for dot in "${DOTS[@]}"; do
    path=$DEST_PATH$dot
    if [ -d "${path}" ]; then
        if [ -n "$(ls -A "$path")" ]; then
            echo "${path} already exists and is not empty!"
            while true; do
                read -p "Do you want to install (creates a backup)? (y/n) " yn
                case $yn in
                    [Yy]*) create_backup $dot; 
                        mkdir -p $path
                        copy_dot $dot
                        break ;;
                    [Nn]*) echo "Skipping ..."; break ;;
                    *) echo "Please answer 'y' or 'n'." ;;
                esac
            done


        else
            # path exists but is empty
            copy_dot $dot
        fi

    else
        echo "Creating ${path} ..."
        copy_dot $dot
    fi
done
