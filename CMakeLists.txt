cmake_minimum_required(VERSION 3.12)

project(aliceVision LANGUAGES C CXX)

option(ALICEVISION_BUILD_DEPENDENCIES "Build all AliceVision dependencies" OFF)
set(AV_BUILD_DEPENDENCIES_PARALLEL 1 CACHE STRING "Number of cores to use when building dependencies (0 - use the number of cores of the processor)")
option(AV_BUILD_CUDA "Enable building an embedded Cuda" OFF)
option(AV_BUILD_ZLIB "Enable building an embedded ZLIB" ON)
option(AV_BUILD_ASSIMP "Enable building an embedded ASSIMP" ON)
option(AV_BUILD_TIFF "Enable building an embedded Tiff" ON)
option(AV_BUILD_JPEG "Enable building an embedded Jpeg" ON)
option(AV_BUILD_PNG "Enable building an embedded Png" ON)
option(AV_BUILD_LIBRAW "Enable building an embedded libraw" ON)
option(AV_BUILD_POPSIFT "Enable building an embedded PopSift" ON)
option(AV_BUILD_CCTAG "Enable building an embedded CCTag" ON)
option(AV_BUILD_APRILTAG "Enable building an embedded AprilTag" ON)
option(AV_BUILD_OPENGV "Enable building an embedded OpenGV" ON)
option(AV_BUILD_OPENCV "Enable building an embedded OpenCV" ON)
option(AV_BUILD_LAPACK "Enable building an embedded Lapack" ON)
option(AV_BUILD_SUITESPARSE "Enable building an embedded SuiteSparse" ON)
option(AV_BUILD_FFMPEG "Enable building an embedded FFMpeg" ON)
option(AV_BUILD_VPX "Enable building an embedded libvpx required for ffmpeg" ON)
option(AV_BUILD_X264 "Enable building an embedded x264 required for ffmpeg" OFF)
option(AV_BUILD_X265 "Enable building an embedded x265 required for ffmpeg" OFF)
option(AV_BUILD_HEIF "Enable building an embedded libheif required for ffmpeg" OFF)
option(AV_BUILD_COINUTILS "Enable building an embedded CoinUtils" ON)
option(AV_BUILD_OSI "Enable building an embedded Osi" ON)
option(AV_BUILD_CLP "Enable building an embedded Clp" ON)
option(AV_BUILD_PCL "Enable building an embedded PointCloud library" ON)
option(AV_BUILD_USD "Enable building an embedded USD library" OFF)
option(AV_BUILD_ALICEVISION "Enable building of AliceVision" ON)
option(AV_EIGEN_MEMORY_ALIGNMENT "Enable Eigen memory alignment" ON)

option(AV_USE_CUDA "Enable CUDA" ON)

# disable by default for AppleClang
option(AV_USE_OPENMP "Enable OpenMP" $<$<CXX_COMPILER_ID:"AppleClang">,OFF,ON>)

option(BUILD_SHARED_LIBS "Build shared libraries" ON)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type for AliceVision" FORCE)
endif()

set(DEPS_CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type for all external libraries (only used if ALICEVISION_BUILD_DEPENDENCIES=ON)")
string(TOLOWER ${DEPS_CMAKE_BUILD_TYPE} DEPS_CMAKE_BUILD_TYPE_LOWERCASE)

option(ALICEVISION_BUILD_TESTS "Build AliceVision tests" OFF)

set(ALICEVISION_BUNDLE_PREFIX "${CMAKE_INSTALL_PREFIX}/bundle" CACHE STRING "Path for bundle installation")

set(ALICEVISION_ROOT ${PROJECT_BINARY_DIR})

# ==============================================================================
# GNUInstallDirs CMake module
# - Define GNU standard installation directories
# - Provides install directory variables as defined by the GNU Coding Standards.
# ==============================================================================
include(GNUInstallDirs)

# Avoid warning about DOWNLOAD_EXTRACT_TIMESTAMP in CMake 3.24:
if (CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
    cmake_policy(SET CMP0135 NEW)
endif()

if(CMAKE_BUILD_TYPE MATCHES Release)
    message(STATUS "Force CMAKE_INSTALL_DO_STRIP in Release")
    set(CMAKE_INSTALL_DO_STRIP TRUE)
endif()

#set(ENV{PKG_CONFIG_PATH} ${CMAKE_INSTALL_PREFIX})
#set($ENV{PKG_CONFIG_PATH} ${CMAKE_INSTALL_PREFIX})
set(CMAKE_INSTALL_LIBDIR lib)
set(CMAKE_PREFIX_PATH ${CMAKE_INSTALL_PREFIX})

message(STATUS "----------------------------------------")
message(STATUS "ALICEVISION_BUILD_DEPENDENCIES: ${ALICEVISION_BUILD_DEPENDENCIES}")
message(STATUS "ALICEVISION_BUILD_TESTS: ${ALICEVISION_BUILD_TESTS}")
message(STATUS "")
message(STATUS "AV_BUILD_CUDA: ${AV_BUILD_CUDA}")
message(STATUS "AV_BUILD_ZLIB: ${AV_BUILD_ZLIB}")
message(STATUS "AV_BUILD_ASSIMP: ${AV_BUILD_ASSIMP}")
message(STATUS "AV_BUILD_TIFF: ${AV_BUILD_TIFF}")
message(STATUS "AV_BUILD_JPEG: ${AV_BUILD_JPEG}")
message(STATUS "AV_BUILD_PNG: ${AV_BUILD_PNG}")
message(STATUS "AV_BUILD_LIBRAW: ${AV_BUILD_LIBRAW}")
message(STATUS "AV_BUILD_CCTAG: ${AV_BUILD_CCTAG}")
message(STATUS "AV_BUILD_APRILTAG: ${AV_BUILD_APRILTAG}")
message(STATUS "AV_BUILD_POPSIFT: ${AV_BUILD_POPSIFT}")
message(STATUS "AV_BUILD_OPENGV: ${AV_BUILD_OPENGV}")
message(STATUS "AV_BUILD_OPENCV: ${AV_BUILD_OPENCV}")
message(STATUS "AV_BUILD_LAPACK: ${AV_BUILD_LAPACK}")
message(STATUS "AV_BUILD_SUITESPARSE: ${AV_BUILD_SUITESPARSE}")
message(STATUS "AV_BUILD_VPX: ${AV_BUILD_VPX}")
message(STATUS "AV_BUILD_X264: ${AV_BUILD_X264}")
message(STATUS "AV_BUILD_X265: ${AV_BUILD_X265}")
message(STATUS "AV_BUILD_HEIF: ${AV_BUILD_HEIF}")
message(STATUS "AV_BUILD_FFMPEG: ${AV_BUILD_FFMPEG}")
message(STATUS "AV_USE_CUDA: ${AV_USE_CUDA}")
message(STATUS "AV_USE_OPENMP: ${AV_USE_OPENMP}")
message(STATUS "AV_BUILD_COINUTILS: ${AV_BUILD_COINUTILS}")
message(STATUS "AV_BUILD_OSI: ${AV_BUILD_OSI}")
message(STATUS "AV_BUILD_CLP: ${AV_BUILD_CLP}")
message(STATUS "AV_BUILD_PCL: ${AV_BUILD_PCL}")
message(STATUS "AV_BUILD_USD: ${AV_BUILD_USD}")
message(STATUS "AV_BUILD_DEPENDENCIES_PARALLEL: ${AV_BUILD_DEPENDENCIES_PARALLEL}")
message(STATUS "")
message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
message(STATUS "DEPS_CMAKE_BUILD_TYPE: ${DEPS_CMAKE_BUILD_TYPE}")
message(STATUS "CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")
message(STATUS "CMAKE_INSTALL_LIBDIR: ${CMAKE_INSTALL_LIBDIR}")
message(STATUS "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")
message(STATUS "CMAKE_INSTALL_RPATH: ${CMAKE_INSTALL_RPATH}")
message(STATUS "CMAKE_INSTALL_DO_STRIP: ${CMAKE_INSTALL_DO_STRIP}")
message(STATUS "----------------------------------------")

# ==============================================================================
# Enable cmake UNIT TEST framework
# ==============================================================================
if(ALICEVISION_BUILD_TESTS)
  enable_testing()
endif()

if(WIN32)
  set(SCRIPT_EXTENSION bat)
else()
  set(SCRIPT_EXTENSION sh)
endif()

if(ALICEVISION_BUILD_DEPENDENCIES)

if(AV_BUILD_DEPENDENCIES_PARALLEL EQUAL 0)
  cmake_host_system_information(RESULT AV_BUILD_DEPENDENCIES_PARALLEL QUERY NUMBER_OF_LOGICAL_CORES)
endif()

# ==============================================================================
# Use CMake ExternalProject to build all dependencies
# ==============================================================================
include(ExternalProject)

set(BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}/external")

set(CMAKE_CORE_BUILD_FLAGS 
	-DCMAKE_BUILD_TYPE=${DEPS_CMAKE_BUILD_TYPE}
	-DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS} 
	-DCMAKE_INSTALL_LIBDIR=lib
	#-DCMAKE_INSTALL_DO_STRIP:BOOL=${CMAKE_INSTALL_DO_STRIP} 
	#-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
	#-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} 
	-DCMAKE_CXX_STANDARD=17)

include(cmake/versions.cmake)

# Add Zlib
if(AV_BUILD_ZLIB)
  include(cmake/zlib.cmake)
else()
  set(ZLIB_TARGET "")	  
endif()

# Add Assimp
if(AV_BUILD_ASSIMP)
  include(cmake/assimp.cmake)
else()
  set(ASSIMP_TARGET "")	  
endif()

# Add Geogram
include(cmake/geogram.cmake)

# Add Cuda
if(AV_USE_CUDA AND AV_BUILD_CUDA)
  include(cmake/cuda.cmake)
else()
  option(CUDA_TOOLKIT_ROOT_DIR "")
  if(CUDA_TOOLKIT_ROOT_DIR)
    set(CUDA_CMAKE_FLAGS -DCUDA_TOOLKIT_ROOT_DIR=${CUDA_TOOLKIT_ROOT_DIR})
  endif()
endif()

# Add Tbb
include(cmake/tbb.cmake)

# Add Eigen
include(cmake/eigen.cmake)

# Add Expat: XML parser
include(cmake/expat.cmake)

# Add ONNXRuntime
include(cmake/onnxruntime.cmake)

if(AV_BUILD_OPENGV)
  include(cmake/opengv.cmake)
endif()

if(AV_BUILD_LAPACK)
  include(cmake/lapack.cmake)
endif()

if(AV_BUILD_SUITESPARSE)
  include(cmake/gmp.cmake)
  include(cmake/mpfr.cmake)
  include(cmake/suitesparse.cmake)
endif()

# Add ceres-solver: A Nonlinear Least Squares Minimizer
include(cmake/ceres.cmake)

# Add OpenEXR
include(cmake/openexr.cmake)

# Add LibTiff
if(AV_BUILD_TIFF)
  include(cmake/tiff.cmake)
endif()

# Add LibPng
if(AV_BUILD_PNG)
  include(cmake/png.cmake)
endif()

if(AV_BUILD_JPEG)
  include(cmake/libjpeg-turbo.cmake)
endif()

if(AV_BUILD_LIBRAW)
  include(cmake/libraw.cmake)
endif()

# Add Boost
include(cmake/boost.cmake)

# Add ffmpeg
if(AV_BUILD_FFMPEG)
  if(AV_BUILD_X264)
    include(cmake/x264.cmake)
  else()
    set(X264_TARGET "")
  endif()

  if(AV_BUILD_X265)
    include(cmake/x265.cmake)
  else()
    set(X265_TARGET "")
  endif()

  if(AV_BUILD_VPX)
    include(cmake/libvpx.cmake)
  else()
    set(VPX_TARGET "")
  endif()

  include(cmake/ffmpeg.cmake)
endif()

# Add libheif
if(AV_BUILD_HEIF)
  include(cmake/libheif.cmake)
else()
  set(HEIF_TARGET "")
endif()

# Add OpenImageIO
include(cmake/openimageio.cmake)

# Add Alembic: I/O for Point Cloud and Cameras
include(cmake/alembic.cmake)

if(AV_BUILD_OPENCV)
  include(cmake/opencv.cmake)
endif()

# Add CCTag
if(AV_BUILD_CCTAG)
  include(cmake/cctag.cmake)
endif()

# Add AprilTag
if(AV_BUILD_APRILTAG)
  include(cmake/apriltag.cmake)
endif()

# Add PopSift
if(AV_BUILD_POPSIFT)
  include(cmake/popsift.cmake)
endif()

if(AV_BUILD_COINUTILS)
  include(cmake/coinutils.cmake)
endif()

if(AV_BUILD_OSI)
  include(cmake/osi.cmake)
endif()

if(AV_BUILD_CLP)
  include(cmake/clp.cmake)
endif()

# Add PCL
if(AV_BUILD_PCL)
  # build other dependencies for pcl
  # add lz4 for flann
  include(cmake/lz4.cmake)

  # @TODO whenever flann will be removed as embedded dependency move this and lz4 out from if(AV_BUILD_PCL) as they will be needed by the library
  # add flann
  include(cmake/flann.cmake)

  # add point cloud library
  include(cmake/pcl.cmake)
endif()

if(AV_BUILD_USD)
  include(cmake/usd.cmake)
else()
  set(USD_TARGET "")
endif()

set(AV_DEPS
  ${ZLIB_TARGET}
  ${ASSIMP_TARGET}
  ${GEOGRAM_TARGET}
  ${CUDA_TARGET}
  ${TBB_TARGET}
  ${EIGEN_TARGET}
  ${ONNXRUNTIME_TARGET}
  ${OPENGV_TARGET}
  ${OPENCV_TARGET}
  ${LAPACK_TARGET}
  ${SUITESPARSE_TARGET}
  ${CERES_TARGET}
  ${OPENEXR_TARGET}
  ${TIFF_TARGET}
  ${PNG_TARGET}
  ${JPEG_TARGET}
  ${LIBRAW_TARGET}
  ${BOOST_TARGET}
  ${OPENIMAGEIO_TARGET}
  ${ALEMBIC_TARGET}
  ${CCTAG_TARGET}
  ${APRILTAG_TARGET}
  ${POPSIFT_TARGET}
  ${EXPAT_TARGET}
  ${COINUTILS_TARGET}
  ${OSI_TARGET}
  ${CLP_TARGET}
  ${USD_TARGET}
)

if(AV_BUILD_ALICEVISION)
  include(cmake/alicevision.cmake)
endif()

else()

# ==============================================================================
# Standard cmake project without internal support for dependencies
# ==============================================================================

# Add sources
add_subdirectory(src)

install(
        FILES LICENSE-MPL2.md LICENSE-MIT-libmv.md COPYING.md CONTRIBUTORS.md
        DESTINATION ${CMAKE_INSTALL_DATADIR}/aliceVision
)

endif()

# Bundle target (see src/cmake/MakeBundle.cmake)
# Note: require that the install rule has been executed

# Include VCPKG installed dir for runtime dependencies lookup
set(BUNDLE_LIBS_PATHS "")
if(_VCPKG_INSTALLED_DIR)
  set(BUNDLE_LIBS_PATHS ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}$<$<CONFIG:Debug>:/debug>/bin)
endif()

add_custom_target(bundle
                  ${CMAKE_COMMAND}
                    # Script arguments:
                    -DBUNDLE_INSTALL_PREFIX=${ALICEVISION_BUNDLE_PREFIX}
                    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                    -DBUNDLE_LIBS_PATHS=${BUNDLE_LIBS_PATHS}
                    # Script:
                    -P ${CMAKE_CURRENT_SOURCE_DIR}/src/cmake/MakeBundle.cmake
                  )
set_target_properties(bundle PROPERTIES FOLDER Packaging)
