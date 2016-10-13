#!/bin/bash

ARCH=$(uname -m)
URL='http://dl.bintray.com/content/lorenzobettini/javamm/products'


href() {

	while read -rd ' ' i; do
		if [[ "${i}" =~ href= ]]; then
			i=$(sed s@href=\"\:@@ <<< "${i}")
			echo $i
		fi
	done
	unset i
}

oshit() {
	echo -e "cannot fetching the version \"${LAST_VERSION}\" from ->\n\t${URL}/${LAST_VERSION}"
}

tagstrip() {

	href|case $1 in
		version) sed s'@/"@@'|tail -1 ;;
		file) sed s'@"@@'|grep "linux"|grep -w "$ARCH" ;;
	esac
}


# -L is for following moved link (errors 3XX)

if ! LAST_VERSION="$(curl -sL "${URL}"|tagstrip version 2>/dev/null)"; then
	echo "cannot get data from \"$URL\" or data or contains unexpected pattern"
else
	echo "LAST VERSION: \"${LAST_VERSION}\" "
	echo "${URL}/${LAST_VERSION}"

	if FILE="$(curl -sL "${URL}/${LAST_VERSION}"|tagstrip file 2>/dev/null)"; then
		wget "${URL}/${LAST_VERSION}/${FILE}" || oshit
	else
		echo "Could not get \"$FILE\" "
	fi

fi
