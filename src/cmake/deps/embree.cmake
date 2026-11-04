# =============================================================================
# deps/embree.cmake
# Dependencies: tbb
# Provides:     EMBREE_TARGET, EMBREE_CMAKE_FLAGS
# =============================================================================

if(AV_BUILD_EMBREE)
    set(EMBREE_TARGET embree)

    # Embree forces -mmacosx-version-min=10.7, for which clang rejects the aligned
    # deallocation functions used by the oneTBB headers. It also drops CMAKE_CXX_FLAGS by default.
    if(APPLE)
        set(DEP_EMBREE_APPLE_FLAGS -DEMBREE_IGNORE_CMAKE_CXX_FLAGS:BOOL=OFF -DCMAKE_CXX_FLAGS=-faligned-allocation)
    endif()

    av_add_cmake_dep(
        TARGET     ${EMBREE_TARGET}
        SOURCE_DIR embree
        URL        ${DEP_EMBREE_URL}
        URL_HASH   ${DEP_EMBREE_HASH}
        EXTRA_CMAKE_FLAGS
            ${TBB_CMAKE_FLAGS}
            -DEMBREE_TUTORIALS:BOOL=OFF
            -DEMBREE_ISPC_SUPPORT:BOOL=OFF
            -DEMBREE_TASKING_SYSTEM=TBB
            ${DEP_EMBREE_APPLE_FLAGS}
        DEPENDS ${TBB_TARGET}
    )

    set(EMBREE_CMAKE_FLAGS
        -Dembree_DIR:PATH=${CMAKE_INSTALL_PREFIX}/lib/cmake/embree-${DEP_EMBREE_VERSION}
    )
endif()
