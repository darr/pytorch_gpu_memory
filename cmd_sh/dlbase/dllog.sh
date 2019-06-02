#!/bin/bash
if [ "$dllog" ]; then
    return
fi

export dllog="dllog.sh"

. dlfile.sh

log_path="./shlog"

DLLOG_DEBUG="dllog_log debug $LINENO $0"
DLLOG_INFO="dllog_log info $LINENO $0"
DLLOG_WARNING="dllog_log warning $LINENO $0"
DLLOG_ERROR="dllog_log error $LINENO $0"

function dllog_log(){
    local now_date=`date "+%Y-%m-%d %H:%M:%S"`
    local user_name=`whoami`
    local log_level=$1
    local line_number=$2
    local file_name=$3
    local content=$4
    local now_day=`date "+%Y-%m-%d"`

    local log_content="LEVEL:$log_level\tUSER:$user_name\tFILE:$file_name\tLINE:$line_number\tFUNC:${FUNCNAME[1]}\tDATE:$now_date CONTENT:$content"
    local log_debug_content="LINE:$line_number\tFUNC:${FUNCNAME[1]}\tFILE:$file_name\tCONTENT:$content"
    local log_write_content="LEVEL:$log_level USER:$user_name FILE:$file_name LINE:$line_number FUNC:${FUNCNAME[1]} DATE:$now_date CONTENT:$content"

    if [ "$log_level" == "error" ] ; then
        echo -e "\033[31m$log_content\033[0m"
    elif [ "$log_level" == "info" ] ; then
        echo -e "\033[32m$log_debug_content\033[0m"
    elif [ "$log_level" == "warning" ] ; then
        echo -e "\033[33m$log_content\033[0m"
    else
        echo -e "\033[32m$log_debug_content\033[0m"
    fi
    dlfile_try_create_dir "$log_path"
    echo $log_write_content >> "$log_path/$now_day.log"
}

function log_test(){
    $DLLOG_DEBUG "debug test"
    $DLLOG_INFO "test"
    $DLLOG_WARNING "test"
    $DLLOG_ERROR "error test"
}

if [ -n "$BASH_SOURCE" -a "$BASH_SOURCE" != "$0" ]
then
    echo
else
    log_test
fi
