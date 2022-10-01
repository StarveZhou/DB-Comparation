#!/bin/bash

# Debug mode
set -x

# Headers
BIN_FILE=$(readlink -f $0)
BIN_DIR=${BIN_FILE%/*}
HEADERS_DIR="${BIN_DIR}/headers"

source ${HEADERS_DIR}/env.sh
source ${HEADERS_DIR}/os.sh

function cmake_debug {
    export Boost_INCLUDE_DIR=${DOWNLOAD_DIR}/boost_1_77_0

    create_dir_if_not_exists $MARIADB_DBG_BUILD_DIR
    cd $MARIADB_DBG_BUILD_DIR
    cmake .. \
        -DWITHOUT_TOKUDB=1 \
        -DBOOST_ROOT=${DOWNLOAD_DIR} \
        -DWITH_INNOBASE_STORAGE_ENGINE=1 \
        -DWITH_ARCHIVE_STPRAGE_ENGINE=1 \
        -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
        -DWIYH_READLINE=1 \
        -DVITH_ZLIB=system \
        -DWITH_LOBWRAP=0 \
        -DCMAKE_BUILD_TYPE=Debug
}

function remake_debug_mariadb {
    cmake_debug

    cd $MARIADB_DBG_BUILD_DIR
    make -j10

    create_dir_if_not_exists ${MARIADB_DBG_INSTALL_DIR}
    rm -rf ${MARIADB_DBG_INSTALL_DIR}/*

    make install DESTDIR=${MARIADB_DBG_INSTALL_DIR}
    mv ${MARIADB_DBG_INSTALL_DIR}/usr/local/mysql ${MARIADB_DBG_INSTALL_DIR}/
    rm -rf ${MARIADB_DBG_INSTALL_DIR}/usr
}

remake_debug_mariadb
