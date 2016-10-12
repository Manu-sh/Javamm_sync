#!/bin/bash

default_path=/opt/javamm

mkdir -p ${default_path} || exit 1
[ -e "${1}" ] && unzip "${1}" -d ${default_path} || exit 1
cp -fv javamm.desktop /usr/share/applications/javamm.desktop || exit 1
