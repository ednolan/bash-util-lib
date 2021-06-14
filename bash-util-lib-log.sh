# -*- mode: sh; sh-shell: bash; -*-

function bash_util_log_fatal() {
    echo "[FATAL] $(date): $@" 1>&2
    exit 1
}

function bash_util_log_warn() {
    echo "[WARN] $(date): $@" 1>&2
}

function bash_util_log_info() {
    echo "[INFO] $(date): $@" 1>&2
}
