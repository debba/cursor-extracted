_cursor_version=0.42.3
_cursor_build=241016kxu9umuir

pkgname=cursor-extracted
pkgver="${_cursor_version}"
pkgrel=1
pkgdesc='Cursor - The AI Code Editor (extracted from Appimage)'
arch=('x86_64')
url='https://www.cursor.com/'
license=('custom:Proprietary')
source_x86_64=("cursor-${_cursor_version}.Appimage::https://download.todesktop.com/230313mzl4w4u92/cursor-${_cursor_version}-build-${_cursor_build}-x86_64.AppImage")
sha512sums_x86_64=('dea1fb3206719dbbe4141a80249a5f52e431f0a4b4a3bf2e042279beb9654b61f240435b3cb84544f909c25d21a138482bf64f8594b7d5b470b681c0c538df3d')
noextract=("${source[@]%%::*}")
options=('!strip' '!debug')

prepare() {
	chmod +x "${srcdir}/cursor-${_cursor_version}.Appimage"
	"${srcdir}/cursor-${_cursor_version}.Appimage" --appimage-extract >/dev/null
	sed 's@AppRun@/usr/bin/cursor@g' -i "${srcdir}/squashfs-root/cursor.desktop"
	cat >"${srcdir}/cursor.sh" <<EOF
#!/usr/bin/env sh
cd /opt/cursor
./cursor "$@"
EOF
}

package() {
	install -Dm755 "${srcdir}/cursor.sh" "${pkgdir}/usr/bin/cursor"
	install -Dm644 "${srcdir}/squashfs-root/cursor.desktop" "${pkgdir}/usr/share/applications/cursor.desktop"

	mkdir -p "${pkgdir}/opt/cursor/"
	cp -r "${srcdir}/squashfs-root/"* "${pkgdir}/opt/cursor/"
	chmod -R go-w "${pkgdir}/opt/cursor"

	find "${srcdir}/squashfs-root/usr/share/icons/hicolor" -type f -name 'cursor.png' |
		sed "s@^${srcdir}/squashfs-root/@@g" |
		xargs -I{} install -Dm644 "${srcdir}/squashfs-root/{}" "${pkgdir}/{}"
}
