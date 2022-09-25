function create_dir_if_not_exists {
    if [ ! $# -eq 1 ]; then
        echo "Create_dir_if_not_exists params error"
        exit 1
    fi

    dirname="$1"
    if [ ! -d "${dirname}" ]; then
        echo "Create dir ${dirname}"
        mkdir -p "${dirname}"
    fi
}
