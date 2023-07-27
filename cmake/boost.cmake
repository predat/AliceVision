set(BOOST_TARGET boost)

# vfxplatform CY2021: 1.73
# vfxplatform CY2022: 1.76
ExternalProject_Add(${BOOST_TARGET}
      #URL https://github.com/alicevision/AliceVisionDependencies/releases/download/boost-src-1.80.0/boost_1_80_0.tar.bz2
      URL https://boostorg.jfrog.io/artifactory/main/release/1.80.0/source/boost_1_80_0.tar.bz2
      URL_HASH MD5=df7dc2fc6de751753198a5bf70210da7
      DOWNLOAD_DIR ${BUILD_DIR}/download/boost
      PREFIX ${BUILD_DIR}
      BUILD_IN_SOURCE 0
      BUILD_ALWAYS 0
      UPDATE_COMMAND ""
      SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/boost
      BINARY_DIR ${BUILD_DIR}/boost_build
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      CONFIGURE_COMMAND cd <SOURCE_DIR> && ./bootstrap.${SCRIPT_EXTENSION} --prefix=<INSTALL_DIR> --with-libraries=atomic,container,date_time,exception,filesystem,graph,iostreams,json,log,math,program_options,regex,serialization,system,test,thread,stacktrace,timer
      BUILD_COMMAND cd <SOURCE_DIR> && ./b2 --prefix=<INSTALL_DIR> variant=${DEPS_CMAKE_BUILD_TYPE_LOWERCASE} link=shared threading=multi -j8
      INSTALL_COMMAND cd <SOURCE_DIR> && ./b2 variant=${DEPS_CMAKE_BUILD_TYPE_LOWERCASE} link=shared threading=multi install
      DEPENDS ${ZLIB_TARGET}
)

set(BOOST_CMAKE_FLAGS -DBOOST_ROOT=${CMAKE_INSTALL_PREFIX})
