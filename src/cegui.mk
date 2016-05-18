# This file is part of MXE.
# See index.html for further information.

PKG             := cegui
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.8.7
$(PKG)_CHECKSUM := b351e8957716d9c170612c13559e49530ef911ae4bac2feeb2dacd70b430e518
$(PKG)_SUBDIR   := cegui-$($(PKG)_VERSION)
$(PKG)_FILE     := cegui-$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := https://bitbucket.org/cegui/cegui/downloads/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc expat freeglut freeimage freetype libxml2 pcre xerces glew

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://bitbucket.org/cegui/cegui/downloads' | \
    $(SED) -n 's,.*href=.*get/v\([0-9]*-[0-9]*-[0-9]*\)\.tar.*,\1,p' | \
    $(SED) 's,-,.,g' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    mkdir '$(1).build'
    cd '$(1).build' && cmake \
        -DCMAKE_TOOLCHAIN_FILE='$(CMAKE_TOOLCHAIN_FILE)' \
        -DBUILD_SHARED_LIBS=$(if $(BUILD_STATIC),FALSE,TRUE) \
        -DCEGUI_BUILD_XMLPARSER_XERCES=TRUE \
        -DCEGUI_BUILD_XMLPARSER_LIBXML2=TRUE \
        -DCEGUI_BUILD_XMLPARSER_EXPAT=TRUE \
        -DCEGUI_BUILD_IMAGECODEC_CORONA=FALSE \
        -DCEGUI_BUILD_IMAGECODEC_DEVIL=FALSE \
        -DCEGUI_BUILD_IMAGECODEC_FREEIMAGE=TRUE \
        -DCEGUI_BUILD_IMAGECODEC_SILLY=FALSE \
        -DCEGUI_BUILD_IMAGECODEC_TGA=TRUE \
        -DCEGUI_BUILD_XMLPARSER_TINYXML=FALSE \
        -DCEGUI_BUILD_IMAGECODEC_STB=TRUE \
        -DCEGUI_BUILD_RENDERER_OPENGL=TRUE \
        -DCEGUI_BUILD_RENDERER_OPENGL3=TRUE \
        -DCEGUI_BUILD_RENDERER_OGRE=FALSE \
        -DCEGUI_BUILD_RENDERER_IRRLICHT=FALSE \
        -DCEGUI_BUILD_RENDERER_DIRECTFB=FALSE \
        -DCEGUI_BUILD_RENDERER_NULL=TRUE \
        -DCEGUI_SAMPLES_ENABLED=FALSE \
        -DCEGUI_BUILD_LUA_MODULE=FALSE \
        -DCEGUI_BUILD_PYTHON_MODULES=FALSE \
        '$(1)'
    $(MAKE) -C '$(1).build' install

    '$(TARGET)-g++' \
        -W -Wall -ansi -pedantic \
         '$(2).cpp' \
         `'$(TARGET)-pkg-config' --cflags --libs CEGUI-OPENGL glut freetype2 libpcre` \
         -lCEGUIFreeImageImageCodec -lCEGUIXercesParser -lCEGUIFalagardWRBase \
         `'$(TARGET)-pkg-config' --libs --cflags freeimage xerces-c` \
         -o '$(PREFIX)/$(TARGET)/bin/test-cegui.exe'
endef

$(PKG)_BUILD_x86_64-w64-mingw32 =

$(PKG)_BUILD_SHARED =
