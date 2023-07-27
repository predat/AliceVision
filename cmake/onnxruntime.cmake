set(ONNXRUNTIME_TARGET onnxruntime)

ExternalProject_Add(${ONNXRUNTIME_TARGET}
      URL ${ONNXRUNTIME_URI}
      URL_HASH ${ONNXRUNTIME_HASH_TYPE}=${ONNXRUNTIME_HASH}
      DOWNLOAD_DIR ${BUILD_DIR}/download/onnxruntime
      SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/onnxruntime
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      PREFIX ${BUILD_DIR}
      CONFIGURE_COMMAND ""
      BUILD_COMMAND ""
      INSTALL_COMMAND sh -c "mkdir -p <INSTALL_DIR>/include <INSTALL_DIR>/lib && cp -r <SOURCE_DIR>/lib/* <INSTALL_DIR>/lib && cp -r <SOURCE_DIR>/include/* <INSTALL_DIR>/include"
)

