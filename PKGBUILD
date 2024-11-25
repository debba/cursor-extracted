_cursor_version=0.43.3
_cursor_build=2411246yqzx1jmm

pkgname=cursor-extracted
pkgver="${_cursor_version}"
pkgrel=1
pkgdesc='Cursor - The AI Code Editor (extracted from Appimage)'
arch=('x86_64')
url='https://www.cursor.com/'
license=('custom:Proprietary')
source_x86_64=("cursor-${_cursor_version}.Appimage::https://download.todesktop.com/230313mzl4w4u92/cursor-${_cursor_version}-build-${_cursor_build}-x86_64.AppImage")
sha512sums_x86_64=('f02cdad2010c6fc40ac71d0b5391c70b53e2d62c9125af1dde0ceb79b3d78a3015312cadeac8d2a45bc71d8c7c6114c28870c6c5e576332b475b5539139100fe')
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
