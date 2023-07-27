# Eigen requires overaligned buffers for maximum efficiency (e.g. on AVX512 buffers may need to
# be aligned to 64 bytes). Fortunately this is fixed in C++17.
# See https://eigen.tuxfamily.org/dox/group__TopicUnalignedArrayAssert.html
# Only change this option to disable it for older compilers or for debug purposes.
if(NOT AV_EIGEN_MEMORY_ALIGNMENT)
  set(EIGEN_CMAKE_ALIGNMENT_FLAGS
      "-DCMAKE_CXX_FLAGS:STRING=-DEIGEN_MAX_ALIGN_BYTES=0 -DEIGEN_MAX_STATIC_ALIGN_BYTES=0"
      "-DCMAKE_C_FLAGS:STRING=-DEIGEN_MAX_ALIGN_BYTES=0 -DEIGEN_MAX_STATIC_ALIGN_BYTES=0")
endif()

ExternalProject_Add(${EIGEN_TARGET}
       URL ${EIGEN_URI}
       URL_HASH ${EIGEN_HASH_TYPE}=${EIGEN_HASH}
       DOWNLOAD_DIR ${BUILD_DIR}/download/eigen
       PREFIX ${BUILD_DIR}
       BUILD_ALWAYS 0
       SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/eigen
       BINARY_DIR ${BUILD_DIR}/eigen_build
       INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
       CMAKE_ARGS 
           ${CMAKE_CORE_BUILD_FLAGS}
           ${EIGEN_CMAKE_ALIGNMENT_FLAGS}
           -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
           <SOURCE_DIR>
       BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
)

set(EIGEN_CMAKE_FLAGS
    ${EIGEN_CMAKE_ALIGNMENT_FLAGS}
    -DEigen3_DIR:PATH=${CMAKE_INSTALL_PREFIX}/share/eigen3/cmake
    -DEIGEN3_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include/eigen3
    -DEIGEN_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include/eigen3
    -DEigen_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include/eigen3
)
