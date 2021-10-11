# Maintainer: everyx <lunt.luo@gmail.com>

_pkgbin=navicat
pkgname=navicat15-premium-cs-appimage
pkgver=15.0.21
pkgrel=2
pkgdesc="Powerful database management & design tool for Win, macOS & Linux."
arch=('x86_64')
url="https://www.navicat.com/en/navicat-15-highlights"
license=('custom:Unlicense')
depends=('zlib')
makedepends=('sed' 'appimagetool-bin')
options=(!strip)
_appimage="${pkgname}-${pkgver}.AppImage"
_glib2="glib2-2.68.4-1-x86_64.pkg.tar.zst"
source_x86_64=("${_appimage}::https://pan.rainss.cc/navicat/${pkgver}/Navicat_Premium_15_cs-x86_64.appimage"
               "${_glib2}::https://archive.archlinux.org/packages/g/glib2/glib2-2.68.4-1-x86_64.pkg.tar.zst")
noextract=("${_appimage} ${_glib2}")
sha256sums_x86_64=('65b97d85b024b343864e0bd535dda6198d872df0d6253a646e9d05160a1a6d6b'
                   'e8e759bd9abb58c93067e199088077f3d6fa2c608ebc6f571cb9dd814812bcea')

prepare() {
    chmod +x "${_appimage}" && ./"${_appimage}" --appimage-extract
    tar xvf ${_glib2} -C squashfs-root
}

build() {
    # Adjust .desktop so it will work outside of AppImage container
    sed -i -E "s|Exec=${_pkgbin}|Exec=env DESKTOPINTEGRATION=false /usr/bin/${_pkgbin}|"\
        "squashfs-root/${_pkgbin}.desktop"
    # rebuild appimage
    unset SOURCE_DATE_EPOCH && appimagetool squashfs-root ${pkgname}-patched.AppImage
    # Fix permissions; .AppImage permissions are 700 for all directories
    chmod -R a-x+rX squashfs-root/usr
}

package() {
    # AppImage
    install -Dm755 "${srcdir}/${pkgname}-patched.AppImage" "${pkgdir}/opt/${pkgname}/${pkgname}.AppImage"

    install -Dm644 "${srcdir}/squashfs-root/${_pkgbin}.desktop"\
            "${pkgdir}/usr/share/applications/${_pkgbin}.desktop"

    install -dm755 "${pkgdir}/usr/share/"
    cp -a "${srcdir}/squashfs-root/usr/share/icons" "${pkgdir}/usr/share/"

    # Symlink executable
    install -dm755 "${pkgdir}/usr/bin"
    ln -s "/opt/${pkgname}/${pkgname}.AppImage" "${pkgdir}/usr/bin/${_pkgbin}"
}
