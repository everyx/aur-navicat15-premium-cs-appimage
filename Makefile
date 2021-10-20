all: clean package install

clean:
	@rm -rf *.AppImage *.pkg.tar.zst src

package:
	@makepkg

install:
	@sudo pacman -U ./navicat*.pkg.tar.zst
