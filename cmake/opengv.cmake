set(OPENGV_TARGET opengv)

ExternalProject_Add(${OPENGV_TARGET}
       # Official repository
       # GIT_REPOSITORY https://github.com/laurentkneip/opengv.git
       # Our fork, with a fix:
       GIT_REPOSITORY ${OPENGV_URI}
       # Use a custom commit with a fix to override the cxx standard from cmake command line
       GIT_TAG ${OPENGV_VERSION}
       PREFIX ${BUILD_DIR}
       BUILD_ALWAYS 0
       SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/opengv
       BINARY_DIR ${BUILD_DIR}/opengv_build
       INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
       CONFIGURE_COMMAND ${CMAKE_COMMAND} ${CMAKE_CORE_BUILD_FLAGS}
           ${EIGEN_CMAKE_FLAGS}
           -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
           <SOURCE_DIR>
       BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
       DEPENDS ${EIGEN_TARGET}
       )
set(OPENGV_CMAKE_FLAGS -DOPENGV_DIR=${CMAKE_INSTALL_PREFIX})
