ExternalProject_Add(${USD_TARGET}
    GIT_REPOSITORY ${USD_URI}
    GIT_TAG ${USD_VERSION}
    PREFIX ${BUILD_DIR}
    BUILD_ALWAYS 0
    CONFIGURE_COMMAND ""
    SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/usd
    BINARY_DIR ${BUILD_DIR}/usd_build
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    BUILD_COMMAND python ${CMAKE_CURRENT_BINARY_DIR}/usd/build_scripts/build_usd.py
        --build-shared
        --no-examples
        --no-tools
        --no-ptex
        --no-prman
        --no-openimageio
        --no-opencolorio
        --no-alembic
        --no-draco
        --no-materialx
        --no-tutorials
        --no-tests
        --no-docs
        --no-python
        <INSTALL_DIR>
    INSTALL_COMMAND ""
)

set(USD_CMAKE_FLAGS -Dpxr_DIR:PATH=${CMAKE_INSTALL_PREFIX})
