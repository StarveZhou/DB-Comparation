#!/bin/bash

# Debug mode
set -x

# Headers
BIN_FILE=$(readlink -f $0)
BIN_DIR=${BIN_FILE%/*}
HEADERS_DIR="${BIN_DIR}/headers"

source ${HEADERS_DIR}/env.sh
source ${HEADERS_DIR}/os.sh
