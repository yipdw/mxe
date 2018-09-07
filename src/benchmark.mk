# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := benchmark
$(PKG)_WEBSITE  := https://github.com/google/benchmark
$(PKG)_DESCR    := Google Benchmark, a microbenchmark support library
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.4.1
$(PKG)_CHECKSUM := f8e525db3c42efc9c7f3bc5176a8fa893a9a9920bbd08cef30fb56a51854d60d
$(PKG)_GH_CONF  := google/benchmark/tags, release-
$(PKG)_DEPS     := cc googletest

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake \
        -DCMAKE_BUILD_TYPE=RELEASE
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' install VERBOSE=1
endef
