ExternalProject_add(x264
      GIT_REPOSITORY ${X264_URI}
      GIT_TAG ${X264_VERSION}
      GIT_PROGRESS ON
      PREFIX ${BUILD_DIR}
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      CONFIGURE_COMMAND
          <SOURCE_DIR>/configure
	  --prefix=<INSTALL_DIR>
	  --disable-static
	  --enable-shared
      BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
      INSTALL_COMMAND $(MAKE) install
)
