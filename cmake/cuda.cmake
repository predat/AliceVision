ExternalProject_Add(${CUDA_TARGET}
       URL ${CUDA_URI}
       DOWNLOAD_NO_EXTRACT 1
       PREFIX ${BUILD_DIR}
       BUILD_ALWAYS 0
       SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/cuda
       BINARY_DIR ${BUILD_DIR}/cuda_build
       INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
       CONFIGURE_COMMAND ""
       BUILD_COMMAND ""
       INSTALL_COMMAND 
       TMPDIR=/datas/tmp sh ${BUILD_DIR}/src/${CUDA_EXE} 
	 --silent 
	 --no-opengl-libs 
	 --toolkit 
	 --toolkitpath=<INSTALL_DIR>
)
