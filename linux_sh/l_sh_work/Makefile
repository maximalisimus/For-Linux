TARGET=mypackage
PREFIX=usr/share
POSTFIX=./
SOURCES=$(TARGET)-installation
tmpdir=./$(TARGET)-master
GITNAME=$(TARGET)-master

DESCENG=Comment for program in $(GITNAME)
DESCRU=Русский коментарий к программе $(GITNAME)

gturl="https://github.com/maximalisimus/$(GITNAME).git"
ICONNAME=$(tmpdir)/icons/$(TARGET)-icon.png
THUMBNAIL=$(POSTFIX)$(PREFIX)/icons/hicolor
ICONINSTALL=$(POSTFIX)$(PREFIX)/icons/hicolor/128x128/apps/$(TARGET)-master.png

.PHONY: all clean build create install uninstall icon shortcut

all: build install clean

clean:
	rm -rf $(tmpdir)

build:
	if [ -d $(tmpdir) ]; then \
		echo "$(tmpdir) Folder it's OK" ;\
	else \
		mkdir -p $(tmpdir) ;\
		git clone $(gturl) $(tmpdir) ;\
	fi \

create:
	if [ -d $(SOURCES) ]; then \
		mkdir -p $(tmpdir)/$(SOURCES) ;\
		mkdir -p $(tmpdir)/icons ;\
		cp -a $(SOURCES)/* $(tmpdir)/$(SOURCES)/ ;\
		cp ./icons/$(TARGET)-icon.png $(tmpdir)/icons/$(TARGET)-icon.png ;\
		rm -rf ./$(SOURCES) ;\
		rm -rf ./icons ;\
	else \
		echo "$(SOURCES) Folder does not and OK" ;\
	fi \

install: create icon shortcut
	rm -rf $(POSTFIX)$(PREFIX)/$(TARGET)-master/ ;\
	mkdir -p $(POSTFIX)$(PREFIX)/$(TARGET)-master/ ;\
	cp -a $(tmpdir)/$(SOURCES)/* $(POSTFIX)$(PREFIX)/$(TARGET)-master/ ;\
	chmod ugo+x $(POSTFIX)$(PREFIX)/$(TARGET)-master/$(TARGET) ;\

uninstall: clean
	rm -rf $(POSTFIX)$(PREFIX)/$(TARGET)-master/ ;\
	rm -rf $(POSTFIX)$(PREFIX)/icons/ ;\
	rm -rf $(POSTFIX)$(PREFIX)/applications/ ;\
	rm -rf $(POSTFIX)$(PREFIX)/ ;\
	rm -rf $(POSTFIX) ;\

icon:
	rm -rf $(POSTFIX)/$(PREFIX)/icons ;\
	mkdir -p $(THUMBNAIL)/16x16/apps/;\
	mkdir -p $(THUMBNAIL)/24x24/apps/;\
	mkdir -p $(THUMBNAIL)/32x32/apps/;\
	mkdir -p $(THUMBNAIL)/64x64/apps/;\
	mkdir -p $(THUMBNAIL)/96x96/apps/;\
	mkdir -p $(THUMBNAIL)/128x128/apps/;\
	cp $(ICONNAME) $(ICONINSTALL) ;\
	convert $(ICONINSTALL) -resize 96x96 $(THUMBNAIL)/96x96/apps/$(TARGET)-master.png;\
	convert $(ICONINSTALL) -resize 64x64 $(THUMBNAIL)/64x64/apps/$(TARGET)-master.png;\
	convert $(ICONINSTALL) -resize 32x32 $(THUMBNAIL)/32x32/apps/$(TARGET)-master.png;\
	convert $(ICONINSTALL) -resize 24x24 $(THUMBNAIL)/24x24/apps/$(TARGET)-master.png;\
	convert $(ICONINSTALL) -resize 16x16 $(THUMBNAIL)/16x16/apps/$(TARGET)-master.png;\

shortcut:
	mkdir -p $(POSTFIX)$(PREFIX)/applications/ ;\
	rm -rf $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	touch $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "[Desktop Entry]" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Exec=sudo /$(PREFIX)/$(TARGET)-master/$(TARGET)" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Type=Application" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Name=$(TARGET)-master" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Name[en]=$(TARGET)-master" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Name[ru]=$(TARGET)-master" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Terminal=true" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Icon=$(TARGET)-master" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Categories=GNOME;GTK;Utility;" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "X-GNOME-UsesNotifications=true" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Comment=$(DESCENG)" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Comment[en]=$(DESCENG)" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	echo "Comment[ru]=$(DESCRU)" >> $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\
	chmod ugo+x $(POSTFIX)$(PREFIX)/applications/$(TARGET)-master.desktop ;\

