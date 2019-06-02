#!/bin/bash
if [ "$dlroot" ]; then
    return
fi

export dlroot="dlroot.sh"

. dllog.sh

function dlroot_check_root_user(){
    local user_name=`whoami`
    if [ "$user_name" == "root" ] ; then
        return 0
    else
        $DLLOG_ERROR "need run with root"
        return 1
    fi
}

function dlroot_change_file_owner(){
    local user_name=$1
    local file_path=$2
    dlroot_check_root_user

    if [[ $? -eq 0 ]]; then
        chown -R $user_name:$user_name "$file_path"
    else
        return
    fi
}

function dlroot_create_and_write_file(){
    local content=$1
    local file_path=$2
    dlroot_check_root_user

    if [[ $? -eq 0 ]]; then
        echo -e $content > $file_path
    else
        return
    fi
}

function dlroot_write_to_file_back(){
    local content=$1
    local file_path=$2
    echo -e $content >> $file_path
}

if [ -n "$BASH_SOURCE" -a "$BASH_SOURCE" != "$0" ]
then
    echo
else
    dlroot_check_root_user
    echo run self
fi
