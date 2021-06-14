# -*- mode: sh; sh-shell: bash; -*-

declare bash_util_persistent_map_script_dir=$(dirname $BASH_SOURCE)
source ${bash_util_persistent_map_script_dir}/bash-util-lib-log.sh
source ${bash_util_persistent_map_script_dir}/bash-util-lib-check.sh

function __bash_util_persistent_map_is_valid() {
    local file="$1"
    [[ -f "$file" ]] || return 1
    cat "$file" | jq --exit-status .
}

function __bash_util_persistent_map_create() {
    local file="$1"
    echo '{}' > "$file"
}

function bash_util_persistent_map_insert() {
    [[ "$#" -ge 3 ]] || bash_util_log_fatal "wrong number of parameters"
    [[ $(bash_util_check_executable_in_path jq) ]] || bash_util_log_fatal "jq not found"
    local file="$1"
    if [[ ! -f "$file" ]] ; then
        __bash_util_persistent_map_create "$file"
    else
        [[ $(__bash_util_persistent_map_is_valid "$file") ]] || bash_util_log_fatal "invalid $file"
    fi
    local key="$2"
    shift 2
    local value="$@"
    cat "$file" | jq --argjson json "\"$value\"" ". + {$key: \$json}" > "$file.tmp"
    mv "$file.tmp" "$file"
}

function bash_util_persistent_map_search() {
    [[ "$#" -eq 2 ]] || bash_util_log_fatal "wrong number of parameters"
    [[ $(bash_util_check_executable_in_path jq) ]] || bash_util_log_fatal "jq not found"
    local file="$1"
    [[ $(__bash_util_persistent_map_is_valid "$file") ]] || bash_util_log_fatal "invalid $file"
    local key="$2"
    if [[ $(cat "$file" | jq "has(\"$key\")") == "false" ]] ; then
        return 1
    fi
    cat "$file" | jq --raw-output ".$key"
}

function bash_util_persistent_map_delete() {
    [[ "$#" -eq 2 ]] || bash_util_log_fatal "wrong number of parameters"
    [[ $(bash_util_check_executable_in_path jq) ]] || bash_util_log_fatal "jq not found"
    local file="$1"
    [[ $(__bash_util_persistent_map_is_valid "$file") ]] || bash_util_log_fatal "invalid $file"
    local key="$2"
    if [[ $(cat "$file" | jq "has(\"$key\")") == "false" ]] ; then
        return 1
    fi
    cat "$file" | jq "del(.$key)" > "$file.tmp"
    mv "$file.tmp" "$file"
}
