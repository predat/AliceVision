ExternalProject_add(${VPX_TARGET}
      GIT_REPOSITORY ${VPX_URI} 
      GIT_TAG ${VPX_VERSION}
      GIT_PROGRESS ON
      PREFIX ${BUILD_DIR}
      BUILD_ALWAYS 0
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      CONFIGURE_COMMAND 
          <SOURCE_DIR>/configure
	  --prefix=<INSTALL_DIR>
          --enable-shared
	  --disable-static
	  --disable-examples
      BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
)
