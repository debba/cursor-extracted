_cursor_version=1.3.8
_cursor_url=https://downloads.cursor.com/production/a1fa6fc7d2c2f520293aad84aaa38d091dee6fef/linux/x64/Cursor-1.3.8-x86_64.AppImage

pkgname=cursor-extracted
pkgver="${_cursor_version}"
pkgrel=1
pkgdesc='Cursor - The AI Code Editor (extracted from Appimage)'
arch=('x86_64')
provides=('cursor')
conflicts=('cursor' 'cursor-bin')
url='https://www.cursor.com/'
license=('custom:Proprietary')
source_x86_64=("cursor-${_cursor_version}.Appimage::${_cursor_url}")
sha512sums_x86_64=('SKIP')
noextract=("${source[@]%%::*}")
options=('!strip' '!debug')

prepare() {
	chmod +x "${srcdir}/cursor-${_cursor_version}.Appimage"
	"${srcdir}/cursor-${_cursor_version}.Appimage" --appimage-extract >/dev/null
	sed 's@AppRun@/usr/bin/cursor@g' -i "${srcdir}/squashfs-root/cursor.desktop"
	sed 's@co.anysphere.cursor@cursor@g' -i "${srcdir}/squashfs-root/cursor.desktop" 
}

package() {
	install -Dm644 "${srcdir}/squashfs-root/cursor.desktop" "${pkgdir}/usr/share/applications/cursor.desktop"

	find "${srcdir}/squashfs-root" -type f |
		sed "s@^${srcdir}/squashfs-root/@@g" |
		xargs -I{} install -D "${srcdir}/squashfs-root/{}" "${pkgdir}/opt/cursor/{}"

	mkdir -p "${pkgdir}/usr/bin"
	ln -sf "/opt/cursor/usr/share/cursor/cursor" "${pkgdir}/usr/bin/cursor"

	find "${srcdir}/squashfs-root/usr/share/icons/hicolor" -type f -name 'cursor.png' |
		sed "s@^${srcdir}/squashfs-root/@@g" |
		xargs -I{} install -Dm644 "${srcdir}/squashfs-root/{}" "${pkgdir}/{}"
}
