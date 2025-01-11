_cursor_version=0.44.11
_cursor_build=250103fqxdt5u9z

pkgname=cursor-extracted
pkgver="${_cursor_version}"
pkgrel=1
pkgdesc='Cursor - The AI Code Editor (extracted from Appimage)'
arch=('x86_64')
url='https://www.cursor.com/'
license=('custom:Proprietary')
source_x86_64=("cursor-${_cursor_version}.Appimage::https://download.todesktop.com/230313mzl4w4u92/cursor-${_cursor_version}-build-${_cursor_build}-x86_64.AppImage")
sha512sums_x86_64=('1ec943d2fcc85b122561750c6d1a2d933e0708709792b51809bf450d01e4c8522ebd1eac8072ce5d6d6eb337ee9a05c134d96a20e779978f4de2e294d1275092')
noextract=("${source[@]%%::*}")
options=('!strip' '!debug')

prepare() {
	chmod +x "${srcdir}/cursor-${_cursor_version}.Appimage"
	"${srcdir}/cursor-${_cursor_version}.Appimage" --appimage-extract >/dev/null
	sed 's@AppRun@/usr/bin/cursor@g' -i "${srcdir}/squashfs-root/cursor.desktop"
}

package() {
	install -Dm644 "${srcdir}/squashfs-root/cursor.desktop" "${pkgdir}/usr/share/applications/cursor.desktop"

	find "${srcdir}/squashfs-root" -type f |
		sed "s@^${srcdir}/squashfs-root/@@g" |
		xargs -I{} install -D "${srcdir}/squashfs-root/{}" "${pkgdir}/opt/cursor/{}"

	mkdir -p "${pkgdir}/usr/bin"
	ln -sf "/opt/cursor/cursor" "${pkgdir}/usr/bin/cursor"

	find "${srcdir}/squashfs-root/usr/share/icons/hicolor" -type f -name 'cursor.png' |
		sed "s@^${srcdir}/squashfs-root/@@g" |
		xargs -I{} install -Dm644 "${srcdir}/squashfs-root/{}" "${pkgdir}/{}"
}
