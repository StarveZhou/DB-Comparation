#!/bin/bash

# Debug mode
set -x

# Headers
BIN_FILE=$(readlink -f $0)
BIN_DIR=${BIN_FILE%/*}
HEADERS_DIR="${BIN_DIR}/headers"

source ${HEADERS_DIR}/env.sh
source ${HEADERS_DIR}/os.sh

function cmake_debug_cleanup {
    rm -rf $MYSQL_DBG_BUILD_DIR/*
}

function cmake_debug {
    create_dir_if_not_exists $MYSQL_DBG_BUILD_DIR
    cd $MYSQL_DBG_BUILD_DIR
    cmake .. \
        -DWITH_BOOST=${DOWNLOAD_DIR} \
        -DWITH_DEBUG=ON \
        -DCMAKE_CXX_FLAGS_DEBUG=' -g -O0 -w ' \
        -DWITH_BREAKPAD=0 \
        -DWITH_EMBEDDED_SERVER=0 \
        -DWITH_CURL=0
}

function cmake_release_cleanup {
    rm -rf $MYSQL_REL_BUILD_DIR/*
}

function cmake_release {
    create_dir_if_not_exists $MYSQL_REL_BUILD_DIR
    cd $MYSQL_REL_BUILD_DIR
    cmake .. \
        -DWITH_BOOST=${DOWNLOAD_DIR} \
        -DWITH_DEBUG=OFF \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_CXX_FLAGS_RELEASE='-ffunction-sections -fdata-sections -O3 -DNDEBUG -w' \
        -DWITH_BREAKPAD=0 \
        -DWITH_EMBEDDED_SERVER=0
}

function remake_debug_mysql {
    # CMake
    cmake_debug

    # Make with 10 threads
    cd $MYSQL_DBG_BUILD_DIR
    make -j10

    create_dir_if_not_exists ${MYSQL_DBG_INSTALL_DIR}
    rm -rf ${MYSQL_DBG_INSTALL_DIR}/*
    # Install into install dir
    make install DESTDIR=${MYSQL_DBG_INSTALL_DIR}

    # Replace installed dir
    mv ${MYSQL_DBG_INSTALL_DIR}/usr/local/mysql ${MYSQL_DBG_INSTALL_DIR}/
    rm -rf ${MYSQL_DBG_INSTALL_DIR}/usr
}

remake_debug_mysql
