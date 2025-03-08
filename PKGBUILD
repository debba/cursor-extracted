_cursor_version=0.46.11
_cursor_build=ae378be9dc2f5f1a6a1a220c6e25f9f03c8d4e19

pkgname=cursor-extracted
pkgver="${_cursor_version}"
pkgrel=1
pkgdesc='Cursor - The AI Code Editor (extracted from Appimage)'
arch=('x86_64')
url='https://www.cursor.com/'
license=('custom:Proprietary')
source_x86_64=("cursor-${_cursor_version}.Appimage::https://anysphere-binaries.s3.us-east-1.amazonaws.com/production/client/linux/x64/appimage/Cursor-${_cursor_version}-${_cursor_build}.deb.glibc2.25-x86_64.AppImage")
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
