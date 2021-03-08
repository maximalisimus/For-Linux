pkgname=aif-master
_pkgrun="aif"
pkgver=2.6
pkgrel=1
arch=('any')
url="https://github.com/maximalisimus/$pkgname/"
license=('GPL')
depends=(dialog parted arch-install-scripts git)
makedepends=(git imagemagick)
replaces=($pkgname)

source=("$pkgname::git+https://github.com/maximalisimus/$pkgname.git"
	)
	
md5sums=('SKIP'
	)

prepare() {
	cd ${srcdir}/$pkgname
	make TARGET=$_pkgrun POSTFIX=./post/ tmpdir=./$pkgname install
}

package() {
	mkdir -p $pkgdir/usr/
	cp -a ${srcdir}/$pkgname/post/usr/* $pkgdir/usr/
}
