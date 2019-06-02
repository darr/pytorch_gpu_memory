#!/bin/bash
if [ "$dlgit" ]; then
    return
fi

export dlgit="dlgit.sh"

. dllog.sh

function dlgit_down(){
    local down_url="$1"
    local folder="$2"

    dlfile_check_is_have_dir $folder

    if [[ $? -eq 0 ]]; then
        dlfile_try_create_dir "$folder"
        git clone $down_url "$folder"
    else
        $DLLOG_INFO "$1 git had been clone"
    fi
}

function dlgit_clone_git(){
    local down_url="$1"
    local folder="$2"
    dlgit_down $down_url $folder
}

if [ -n "$BASH_SOURCE" -a "$BASH_SOURCE" != "$0" ]
then
    echo
else
    echo fun self
fi
