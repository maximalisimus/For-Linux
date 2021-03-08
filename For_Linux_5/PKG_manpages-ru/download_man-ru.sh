#!/bin/bash
#
# Ubuntu manpages-ru
# manpages-ru_0.98-4_all.deb
# manpages-ru_0.98.orig.tar.gz
# https://mirror.yandex.ru/ubuntu/pool/universe/m/manpages-ru/
_url="https://mirror.yandex.ru/ubuntu/pool/universe/m/manpages-ru/"
_full_url=""
_pkgs=$(curl -s "$_url" | sed -e 's/<[^>]*>//g' | awk '!/^$/{print $0}' | sed 's/^[ \t]*//' | grep -Ei "^m" | cut -d ' ' -f1 | grep -Ei "deb")
_full_url="${_url}${_pkgs}"
curl -O "${_full_url[*]}"
sed -i "/source/c source=(\"ubuntu-${_pkgs[*]}\"" PKGBUILD
_vers=$(echo "${_pkgs[*]}" | cut -d '_' -f2 | sed 's/-.*//')
_rel=$(echo "${_pkgs[*]}" | cut -d '_' -f2 | rev | sed 's/-.*//' | rev)
sed -i "/pkgver/c pkgver=${_vers[*]}" PKGBUILD
sed -i "/pkgrel/c pkgrel=${_rel[*]}" PKGBUILD
exit 0

