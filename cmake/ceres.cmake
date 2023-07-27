ExternalProject_Add(${CERES_TARGET}
       GIT_REPOSITORY ${CERES_URI}
       GIT_TAG ${CERES_VERSION}
       PREFIX ${BUILD_DIR}
       BUILD_ALWAYS 0
       SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/ceres-solver
       BINARY_DIR ${BUILD_DIR}/ceres_build
       INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
       CMAKE_ARGS
           ${CMAKE_CORE_BUILD_FLAGS}
           ${SUITESPARSE_CMAKE_FLAGS}
           -DSUITESPARSE:BOOL=ON
           -DLAPACK:BOOL=ON
           ${EIGEN_CMAKE_FLAGS}
           -DMINIGLOG=ON
           -DBUILD_EXAMPLES:BOOL=OFF
           -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
           <SOURCE_DIR>
       BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
       DEPENDS ${EIGEN_TARGET} ${SUITESPARSE_TARGET}
)

set(CERES_CMAKE_FLAGS ${SUITESPARSE_CMAKE_FLAGS} -DCeres_DIR=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/cmake/Ceres)
