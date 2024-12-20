_cursor_version=0.44.5
_cursor_build=241220s3ux0e1tv

pkgname=cursor-extracted
pkgver="${_cursor_version}"
pkgrel=1
pkgdesc='Cursor - The AI Code Editor (extracted from Appimage)'
arch=('x86_64')
url='https://www.cursor.com/'
license=('custom:Proprietary')
source_x86_64=("cursor-${_cursor_version}.Appimage::https://download.todesktop.com/230313mzl4w4u92/cursor-${_cursor_version}-build-${_cursor_build}-x86_64.AppImage")
sha512sums_x86_64=('27e3d576446d2c9042e8d413e260a8cdda09f8829107fe618660fda0c6da3e2638949bdeeb94259157ad178217b9bc4b3f8d0e6095cd5acbf9d76d8b5fd8a116')
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
