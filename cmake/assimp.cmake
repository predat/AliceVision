set(ASSIMP_BUILD_OPTIONS 
    -DASSIMP_BUILD_ASSIMP_TOOLS:BOOL=OFF
    -DASSIMP_BUILD_TESTS:BOOL=OFF
    -DASSIMP_BUILD_DRACO:BOOL=ON
)

ExternalProject_Add(${ASSIMP_TARGET}
    URL ${ASSIMP_URI}
    URL_HASH ${ASSIMP_HASH_TYPE}=${ASSIMP_HASH}
    DOWNLOAD_DIR ${BUILD_DIR}/download/assimp
    PREFIX ${BUILD_DIR}
    SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/assimp
    BINARY_DIR ${BUILD_DIR}/assimp_build
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CONFIGURE_COMMAND ${CMAKE_COMMAND} ${CMAKE_CORE_BUILD_FLAGS}
        ${ASSIMP_BUILD_OPTIONS}
        ${ZLIB_CMAKE_FLAGS}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DASSIMP_WARNINGS_AS_ERRORS=OFF
        -DASSIMP_BUILD_TESTS=OFF
        <SOURCE_DIR>
    DEPENDS ${ZLIB_TARGET}
)

set(ASSIMP_CMAKE_FLAGS
	-DAssimp_DIR:PATH=${CMAKE_INSTALL_PREFIX}/lib/cmake/assimp-${ASSIMP_VERSION}
)
