ExternalProject_add(${FFMPEG_TARGET}
      URL ${FFMPEG_URI}
      URL_HASH ${FFMPEG_HASH_TYPE}=${FFMPEG_HASH}
      DOWNLOAD_DIR ${BUILD_DIR}/download/ffmpeg
      PREFIX ${BUILD_DIR}
      BUILD_ALWAYS 0
      INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
      CONFIGURE_COMMAND 
            <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>
            --extra-cflags="-I<INSTALL_DIR>/include"
            --extra-ldflags="-L<INSTALL_DIR>/lib"
            --enable-shared
            --disable-static
            --disable-gpl
            --enable-nonfree
            --enable-libvpx
            # --enable-libfreetype
            # --enable-libfdk-aac # audio
            # --enable-libmp3lame # audio
            # --enable-libopus # audio
            # --enable-libvorbis # audio
            # --enable-libx264 # gpl
            # --enable-libx265 # gpl
      BUILD_COMMAND $(MAKE) -j${AV_BUILD_DEPENDENCIES_PARALLEL}
      DEPENDS ${VPX_TARGET}
)
