#!/bin/bash

default_path=/opt/javamm

mkdir -p ${default_path} || exit 1
[ -e "${1}" ] && unzip "${1}" -d ${default_path} || exit 1
cp -fv javamm.desktop /usr/share/applications/javamm.desktop || exit 1


! which xdg-user-dir && echo "please install xdg-user-dir to create a symlink on desktop" && exit

DESKTOP=$(xdg-user-dir DESKTOP)
cp -fv javamm.desktop $DESKTOP/javamm.desktop || exit 1
