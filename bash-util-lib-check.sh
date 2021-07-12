# -*- mode: sh; sh-shell: bash; -*-

declare bash_util_check_script_dir=$(dirname $BASH_SOURCE)
source ${bash_util_check_script_dir}/bash-util-lib-log.sh

function bash_util_check_min_bash_version() {
    [[ "$#" -eq 3 ]] || bash_util_log_fatal "wrong number of parameters"
    local -i major_version="$1"
    local -i minor_version="$2"
    local -i patch_version="$3"
    if [[ "${BASH_VERSINFO[0]}" -lt "$major_version" ||
              ( "${BASH_VERSINFO[0]}" -eq "$major_version" &&
                    "${BASH_VERSINFO[1]}" -lt "$minor_version" ) ||
              ( "${BASH_VERSINFO[0]}" -eq "$major_version" &&
                    "${BASH_VERSINFO[1]}" -eq "$minor_version" &&
                    "${BASH_VERSINFO[2]}" -lt "$patch_version" ) ]] ; then
        return 1
    fi
    return 0
}

function bash_util_check_executable_in_path() {
    [[ "$#" -eq 1 ]] || bash_util_log_fatal "wrong number of parameters"
    local executable="$1"
    bash -c "type -P $executable" >/dev/null
}

function bash_util_check_script_sourced() {
    # https://stackoverflow.com/a/2684300
    [[ "${BASH_SOURCE[0]}" != "${0}" ]]
}
