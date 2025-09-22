#!/usr/bin/env bash

version=$1
url=$2

echo $version $url

sed -r "s@^(_cursor_version=).+@\1${version}@g" -i PKGBUILD
sed -r "s@^(_cursor_url=).+@\1${url}@g" -i PKGBUILD
makepkg --printsrcinfo > .SRCINFO
git commit -am "${version}"
