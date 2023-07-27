ExternalProject_Add(${LAPACK_TARGET}
       URL ${LAPACK_URI}
       URL_HASH ${LAPACK_HASH_TYPE}=${LAPACK_HASH}
       DOWNLOAD_DIR ${BUILD_DIR}/download/lapack
       PREFIX ${BUILD_DIR}
       BUILD_ALWAYS 0
       UPDATE_COMMAND ""
       SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/lapack
       BINARY_DIR ${BUILD_DIR}/lapack_build
       INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
       CMAKE_ARGS 
           ${CMAKE_CORE_BUILD_FLAGS}
           -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
           <SOURCE_DIR>
       BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
       DEPENDS ${TBB_TARGET}
)

set(BLAS_LIBRARIES ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/libblas${CMAKE_SHARED_LIBRARY_SUFFIX})
set(LAPACK_LIBRARIES ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/liblapack${CMAKE_SHARED_LIBRARY_SUFFIX})
set(LAPACK_CMAKE_FLAGS -DBLAS_LIBRARIES=${BLAS_LIBRARIES} -DLAPACK_LIBRARIES=${LAPACK_LIBRARIES})
