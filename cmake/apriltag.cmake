ExternalProject_Add(${APRILTAG_TARGET}
      URL ${APRILTAG_URI}
      GIT_TAG ${APRILTAG_VERSION}
      PREFIX ${BUILD_DIR}
      BUILD_ALWAYS 0
      SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/apriltag
      BINARY_DIR ${BUILD_DIR}/apriltag_build
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      CMAKE_ARGS 
          ${CMAKE_CORE_BUILD_FLAGS}
          -DBUILD_PYTHON_WRAPPER=OFF
          -DOpenCV_FOUND=OFF
          -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
          <SOURCE_DIR>
      BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
)

set(APRILTAG_CMAKE_FLAGS -Dapriltag_DIR:PATH=${CMAKE_INSTALL_PREFIX}/share/apriltag/cmake)
