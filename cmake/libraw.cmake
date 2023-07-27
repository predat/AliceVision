# Add libraw
ExternalProject_Add(libraw_cmake
      GIT_REPOSITORY https://github.com/LibRaw/LibRaw-cmake
      GIT_TAG 6e26c9e73677dc04f9eb236a97c6a4dc225ba7e8
      PREFIX ${BUILD_DIR}
      BUILD_IN_SOURCE 0
      BUILD_ALWAYS 0
      UPDATE_COMMAND ""
      SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/libraw_cmake
      BINARY_DIR ${BUILD_DIR}/libraw_build
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      CONFIGURE_COMMAND ""
      BUILD_COMMAND ""
      INSTALL_COMMAND ""
)

ExternalProject_Add(${LIBRAW_TARGET}
      GIT_REPOSITORY ${LIBRAW_URI}
      GIT_TAG ${LIBRAW_VERSION}
      PREFIX ${BUILD_DIR}
      BUILD_ALWAYS 0
      SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/libraw
      BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/libraw
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      # Native libraw configure script doesn't work on centos 7 (autoconf 2.69)
      # CONFIGURE_COMMAND autoconf && ./configure --enable-jpeg --enable-openmp --disable-examples --prefix=<INSTALL_DIR>
      # Use cmake build system (not maintained by libraw devs)
      CONFIGURE_COMMAND cp <SOURCE_DIR>_cmake/CMakeLists.txt . &&
          cp -rf <SOURCE_DIR>_cmake/cmake . &&
          ${CMAKE_COMMAND} ${CMAKE_CORE_BUILD_FLAGS}
          -DENABLE_OPENMP=${AV_USE_OPENMP}
          -DENABLE_LCMS=ON
          -DENABLE_EXAMPLES=OFF
          ${ZLIB_CMAKE_FLAGS}
          -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
          -DINSTALL_CMAKE_MODULE_PATH:PATH=<INSTALL_DIR>/cmake
          <SOURCE_DIR>
      BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
      DEPENDS libraw_cmake ${ZLIB_TARGET}
)

SET(LIBRAW_CMAKE_FLAGS -DLIBRAW_PATH=${CMAKE_INSTALL_PREFIX} -DPC_LIBRAW_INCLUDEDIR=${CMAKE_INSTALL_PREFIX}/include -DPC_LIBRAW_LIBDIR=${CMAKE_INSTALL_PREFIX}/lib -DPC_LIBRAW_R_LIBDIR=${CMAKE_INSTALL_PREFIX}/lib)
