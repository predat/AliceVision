ExternalProject_add(${GMP_TARGET}
      URL ${GMP_URI}
      URL_HASH ${GMP_HASH_TYPE}=${GMP_HASH}
      DOWNLOAD_DIR ${BUILD_DIR}/download/gmp
      PREFIX ${BUILD_DIR}
      BUILD_ALWAYS 0
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      CONFIGURE_COMMAND 
        <SOURCE_DIR>/configure 
	--prefix=<INSTALL_DIR>
	--enable-cxx
      BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
)
