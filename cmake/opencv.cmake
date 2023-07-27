ExternalProject_Add(opencv_contrib
  URL https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip
  URL_HASH MD5=a3969f1db6732340e492c0323178f6f1
  DOWNLOAD_DIR ${BUILD_DIR}/download/opencv_contrib
  SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/opencv_contrib
  BUILD_ALWAYS 0
  UPDATE_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ""
)

ExternalProject_Add(${OPENCV_TARGET}
  DEPENDS opencv_contrib ${TBB_TARGET} ${ZLIB_TARGET} ${OPENEXR_TARGET} ${TIFF_TARGET} ${PNG_TARGET} ${JPEG_TARGET} ${LIBRAW_TARGET} ${FFMPEG_TARGET}
  URL ${OPENCV_URI}
  URL_HASH ${OPENCV_HASH_TYPE}=${OPENCV_HASH}
  DOWNLOAD_DIR ${BUILD_DIR}/download/opencv
  BUILD_ALWAYS 0
  SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/opencv
  BINARY_DIR ${BUILD_DIR}/opencv_build
  INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
  CMAKE_ARGS
    ${CMAKE_CORE_BUILD_FLAGS}
    -DOPENCV_EXTRA_MODULES_PATH=${CMAKE_CURRENT_BINARY_DIR}/opencv_contrib/modules
    ${ZLIB_CMAKE_FLAGS}
    ${TBB_CMAKE_FLAGS}
    ${TIFF_CMAKE_FLAGS}
    ${PNG_CMAKE_FLAGS}
    ${JPEG_CMAKE_FLAGS}
    ${LIBRAW_CMAKE_FLAGS}
    -DWITH_TBB=ON
    -DWITH_FFMPEG=${AV_BUILD_FFMPEG}
    -DBUILD_opencv_python2=OFF
    -DBUILD_opencv_python3=OFF
    -DWITH_GTK_2_X=OFF
    -DWITH_V4L=OFF
    -DINSTALL_C_EXAMPLES=OFF
    -DINSTALL_PYTHON_EXAMPLES=OFF
    -DBUILD_EXAMPLES=OFF
    -DWITH_QT=OFF
    -DWITH_OPENGL=OFF
    -DWITH_VTK=OFF
    -DWITH_OPENEXR=OFF  # Build error on IlmBase includes without "OpenEXR/" prefix
    -DENABLE_PRECOMPILED_HEADERS=OFF
    -DBUILD_SHARED_LIBS=ON
    -DWITH_CUDA=OFF
    -DWITH_OPENCL=OFF
    -DBUILD_TESTS=OFF
    -DBUILD_LIST=core,improc,photo,objdetect,video,imgcodecs,videoio,features2d,xfeatures2d,version,mcc,optflow
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    <SOURCE_DIR>
  BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
)

#set(OPENCV_CMAKE_FLAGS -DOpenCV_DIR=${BUILD_DIR}/opencv_install -DCMAKE_PREFIX_PATH=${BUILD_DIR}/opencv_install)
set(OPENCV_CMAKE_FLAGS -DOpenCV_DIR=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/cmake/opencv4 -DOPENCV_DIR=${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/cmake/opencv4)
