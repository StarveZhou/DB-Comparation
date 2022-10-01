#!/bin/bash
export SRC_DIR="/home/zhoujy/code/DB-Comparation/db/mariadb"
export BASE_DIR="/home/zhoujy/code/DB-Comparation/install/mariadb/debug/mysql/"
export BIN_DIR="/home/zhoujy/code/DB-Comparation/install/mariadb/debug/mysql/bin"

function initialize {
    # ${BIN_DIR}/mysqld --defaults-file=mariadb-debug.cnf -uroot --initialize-insecure
    ${BIN_DIR}/../scripts/mysql_install_db --defaults-file=mariadb-debug.cnf --user=zhoujy
}

function start {
    ${BIN_DIR}/mysqld --defaults-file=mariadb-debug.cnf -uzhoujy &
}

function stop {
    mysql_pid=$(cat data/z0ubuntu.pid)
    kill $mysql_pid
}

function client {
    ${BIN_DIR}/mysql -S data/mysql.sock -uzhoujy
}
