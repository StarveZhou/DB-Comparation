#!/bin/bash
export BIN_DIR="/home/zhoujy/code/DB-Comparation/install/mysql/debug/mysql/bin"

function initialize {
    ${BIN_DIR}/mysqld --defaults-file=mysql-debug.cnf -uroot --initialize-insecure
}

function start {
    ${BIN_DIR}/mysqld --defaults-file=mysql-debug.cnf -uroot &
}

function stop {
    mysql_pid=$(cat data/z0ubuntu.pid)
    kill $mysql_pid
}

function client {
    ${BIN_DIR}/mysql -S data/mysql.sock -uroot
}
