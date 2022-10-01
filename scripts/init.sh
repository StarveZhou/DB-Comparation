#!/bin/bash

# Debug mode
set -x

# Headers
BIN_FILE=$(readlink -f $0)
BIN_DIR=${BIN_FILE%/*}
HEADERS_DIR="${BIN_DIR}/headers"

source ${HEADERS_DIR}/env.sh
source ${HEADERS_DIR}/os.sh

create_dir_if_not_exists "${DOWNLOAD_DIR}"

# Initialize for mysql build
function mysql_init {
    # Boost 1_77_0
    BOOST_DOWNLOAD_URI="https://boostorg.jfrog.io/artifactory/main/release/1.77.0/source/boost_1_77_0.tar.bz2"
    BOOST_TAR_BZ="${DOWNLOAD_DIR}/boost_1_77_0.tar.bz2"
    BOOST_DIR="${DOWNLOAD_DIR}/boost_1_77_0"

    if [ -d "${BOOST_DIR}" ]; then
        echo "Already exists: ${BOOST_DIR}"
    else
        # Download boost_1_77_0
        echo "Check boost file"
        if [ -f ${BOOST_TAR_BZ} ]; then
            echo "Already exists: ${BOOST_TAR_BZ}"
        else
            echo "Download boost 1_77_0"
            wget -P ${DOWNLOAD_DIR} ${BOOST_DOWNLOAD_URI}
        fi

        # Extract boost_1_77_0
        echo "Check boost dir"
        echo "Extract boost into dir"
        tar -jxf $BOOST_TAR_BZ -C ${DOWNLOAD_DIR}
    fi

    # Openssl
    sudo apt install -y openssl libssl-dev
    # Curses
    sudo apt install -y libncurses5-dev
    # Bison & yacc
    sudo apt install -y flex bison
    # Fido
    # sudo apt install -y libudev-dev

    echo "Init over"
}

function mariadb_init {
    # sudo apt-get install software-properties-common devscripts equivs
    # sudo apt-key adv --recv-keys \
    #   --keyserver hkp://keyserver.ubuntu.com:80 \
    #   0xF1656F24C74CD1D8
    # sudo add-apt-repository --update --yes --enable-source \
    #    'deb [arch=amd64] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.3/ubuntu '$(lsb_release -sc)' main'
    
    sudo apt-get install libboost-all-dev
    sudo apt install libsnappy-dev
    sudo apt install curl libcurl4-openssl-dev
    sudo apt -y install liblz4-dev
    sudo apt install liblzo2-dev
    sudo apt install libzstd-dev
}

