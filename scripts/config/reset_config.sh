# reset_config ${config_file} ${base_dir} ${PORT}
function reset_config {
    if [ ! $# -eq 3 ]; then
        echo "Reset_config params error"
        exit 1
    fi

    config_file="$0"
    base_dir="$1"
    port="$2"

}
