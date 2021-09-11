# Maintainer: everyx <lunt.luo@gmail.com>

_pkgbin=navicat
pkgname=navicat15-premium-cs-appimage
pkgver=15.0.21
pkgrel=1
pkgdesc="Powerful database management & design tool for Win, macOS & Linux."
arch=('x86_64')
url="https://www.navicat.com/en/navicat-15-highlights"
license=('custom:Unlicense')
depends=('zlib')
options=(!strip)
_appimage="${pkgname}-${pkgver}.AppImage"
source_x86_64=("${_appimage}::https://pan.rainss.cc/navicat/${pkgver}/Navicat_Premium_15_cs-x86_64.appimage")
noextract=("${_appimage}")
sha256sums_x86_64=('65b97d85b024b343864e0bd535dda6198d872df0d6253a646e9d05160a1a6d6b')

prepare() {
    chmod +x "${_appimage}"
    ./"${_appimage}" --appimage-extract
}

build() {
    # Adjust .desktop so it will work outside of AppImage container
    sed -i -E "s|Exec=${_pkgbin}|Exec=env DESKTOPINTEGRATION=false /usr/bin/${_pkgbin}|"\
        "squashfs-root/${_pkgbin}.desktop"
    # Fix permissions; .AppImage permissions are 700 for all directories
    chmod -R a-x+rX squashfs-root/usr
}

package() {
    # AppImage
    install -Dm755 "${srcdir}/${_appimage}" "${pkgdir}/opt/${pkgname}/${pkgname}.AppImage"
    
    install -Dm644 "${srcdir}/squashfs-root/${_pkgbin}.desktop"\
            "${pkgdir}/usr/share/applications/${_pkgbin}.desktop"

    install -dm755 "${pkgdir}/usr/share/"
    cp -a "${srcdir}/squashfs-root/usr/share/icons" "${pkgdir}/usr/share/"

    # Symlink executable
    install -dm755 "${pkgdir}/usr/bin"
    ln -s "/opt/${pkgname}/${pkgname}.AppImage" "${pkgdir}/usr/bin/${_pkgbin}"
}
