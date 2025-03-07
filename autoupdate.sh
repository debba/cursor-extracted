#!/usr/bin/env bash

set -e

curl 'https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=latest' -o latest.json

version="$(grep -Po '/Cursor\-\K[^\-]+' latest.json)"
build="$(grep -Po '/Cursor\-.+?-\K[^\.]+' latest.json)"

rm latest.json

echo $version $build

sed -r "s@^(_cursor_version=).+@\1${version}@g" -i PKGBUILD
sed -r "s@^(_cursor_build=).+@\1${build}@g" -i PKGBUILD
makepkg --printsrcinfo > .SRCINFO
git commit -am "${version}"