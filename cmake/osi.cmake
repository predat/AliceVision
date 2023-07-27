ExternalProject_Add(${OSI_TARGET}
      GIT_REPOSITORY ${OSI_URI}
      GIT_TAG ${OSI_VERSION}
      PREFIX ${BUILD_DIR}
      BUILD_ALWAYS 0
      SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/osi
      BINARY_DIR ${BUILD_DIR}/osi_build
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      CMAKE_ARGS 
          ${CMAKE_CORE_BUILD_FLAGS}
          -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
          <SOURCE_DIR>
      BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
      DEPENDS ${COINUTILS_TARGET}
)

set(OSI_CMAKE_FLAGS -DOsi_DIR=${CMAKE_INSTALL_PREFIX}/share/osi)
