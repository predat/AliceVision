# Add turbojpeg
ExternalProject_Add(${JPEG_TARGET}
       URL ${JPEG_URI}
       URL_HASH ${JPEG_HASH_TYPE}=${JPEG_HASH}
       DOWNLOAD_DIR ${BUILD_DIR}/download/libjpeg-turbo
       PREFIX ${BUILD_DIR}
       BUILD_ALWAYS 0
       SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/turbojpeg
       BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/turbojpeg_build
       INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
       CMAKE_ARGS 
           ${CMAKE_CORE_BUILD_FLAGS}
           ${ZLIB_CMAKE_FLAGS}
           -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
           <SOURCE_DIR>
       BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
       DEPENDS ${ZLIB_TARGET}
)

set(JPEG_CMAKE_FLAGS
	-DJPEG_LIBRARY=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/libjpeg${CMAKE_SHARED_LIBRARY_SUFFIX}
	-DJPEG_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include
)
