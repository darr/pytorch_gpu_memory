#!/bin/bash
if [ "$dlfile" ]; then
    return
fi

export dlfile="dlfile"

. dllog.sh

function dlfile_create_dir(){
   mkdir $1
   if [[ $? -eq 0 ]]; then
        echo create $1 folder sucess;
        return 0
   else
        echo create $1 folder fail;
        return 1
   fi
}

function dlfile_touch_file(){
    if [ ! -f "$1" ]; then
        touch "$1"
    fi
}

function dlfile_check_is_have_dir(){
   if [ ! -d "$1" ]; then
#       echo $1 folder do not exist
       return 0
   else
#       echo $1 folder exist
       return 1
   fi
}

function dlfile_check_is_have_file(){
   if [ ! -f "$1" ]; then
       $DLLOG_DEBUG "$1 file do not exit"
       return 0
   else
       $DLLOG_DEBUG "$1 file exit"
       return 1
   fi
}

function dlfile_try_create_dir(){
    dlfile_check_is_have_dir $1
    if [[ $? -eq 0 ]]; then
        dlfile_create_dir $1
    fi
}

function dlfile_scp_file(){
    local copy_comand=$1
    local file_host_password=$2
    local file_copy_full_name=$3

    dlfile_check_is_have_file "$file_copy_full_name"

    if [[ $? -eq 0 ]]; then
        dlfile_scp_file_without_check "$copy_comand" "$file_host_password"
    else
        $DLLOG_INFO "$3 have the file"
    fi
}

function dlfile_scp_file_without_check(){
    local copy_comand=$1
    local file_host_password=$2
    # should install expect
    # yum -y install expect

    expect -c "
    spawn scp -r $copy_comand
    expect {
    \"*assword\" {set timeout 300; send \"$file_host_password\r\";}
    \"yes/no\" {send \"yes\r\"; exp_continue;}
    }
    expect eof"
}

