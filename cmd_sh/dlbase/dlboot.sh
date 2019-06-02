#!/bin/bash
if [ "$dlboot" ]; then
    return
fi

export dlboot="dlboot.sh"

. dllog.sh
. dlfile.sh

function dlboot_create_auto_start_file(){
    local user_name="$1"
    local file_name="$2"
    local file_path="/home/$user_name"
    local file_full_name="$file_path/$file_name"
    $DLLOG_INFO $file_full_name
    dlfile_check_is_have_file $file_full_name

    if [[ $? -eq 0 ]]; then
        echo \#!/bin/sh > $file_full_name
        chmod +x $file_full_name
        dlboot_set_shell_auto_run "$user_name" "$file_full_name"
    else
        echo \#!/bin/sh > $file_full_name
        chmod +x $file_full_name
        $DLLOG_INFO "$fill_full_name exist auto run file"
    fi
}

function dlboot_set_shell_auto_run(){
    local user_name="$1"
    local file_full_name="$2"
    echo su $user_name -c \"$file_full_name\" >> /etc/rc.d/rc.local
    chmod +x /etc/rc.d/rc.local
}

function dlboot_set_progress_auto_start(){
    local user_name="$1"
    local file_name="$2"
    local content="$3"
    local file_path="/home/$user_name"
    local file_full_name="$file_path/$file_name"
    dlfile_check_is_have_file $file_full_name
    if [[ $? -eq 0 ]]; then
        dlboot_create_auto_start_file  "$user_name" "$file_name"
        echo -e $content >> $file_full_name
    else
        echo -e $content >> $file_full_name
    fi
}

if [ -n "$BASH_SOURCE" -a "$BASH_SOURCE" != "$0" ]
then
    echo
else
    echo self run
fi
