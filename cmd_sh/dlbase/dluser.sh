#!/bin/bash
if [ "$dluser" ]; then
    echo do not need import dluser.sh
    return
fi

export dluser="dluser.sh"

. dlroot.sh

function dluser_find_user(){  
    user_name=$1
    [ -z $1 ] && return 0
    if id $1 &> /dev/null ;then 
        return 1
    else
        return 0
    fi
}

function dluser_del_user(){
    user_name=$1
    dluser_find_user $user_name

    Res=$?
    if [ $Res -eq 1 ]
    then
        dlroot_check_root_user
        if [[ $? -eq 0 ]]; then
            $DLLOG_INFO "delete the user:$user_name"
            userdel -r $user_name
        else
            return
        fi
    else
        $DLLOG_INFO "do not have the user"
    fi
}

function dluser_create_user(){
    user_name=$1
    dluser_find_user $user_name

    Res=$?
    if [ $Res -eq 1 ]
    then
        $DLLOG_INFO "have the user"
    else
        dlroot_check_root_user
        if [[ $? -eq 0 ]]; then
            $DLLOG_INFO "do not have the user:$user_name create the user"
            adduser $1
        else
            return
        fi
    fi
}

function dluser_set_user_password(){
    user_name=$1
    user_password=$2

    dluser_find_user $user_name

    Res=$?
    if [ $Res -eq 1 ]
    then
        #判断密码是否被锁定 
        is_user_locked=`passwd -S $user_name|awk '{print $2}'`
        if [ "$is_user_locked" == "LK" ]
        then
            $DLLOG_INFO "You need input user password"
            passwd $user_name;
        elif [ "$is_user_locked" == "PS" ]
        then
            $DLLOG_INFO "user password has been set before,you can check it"
        else
            $DLLOG_WARNING "unknow lock status: $is_user_locked"
        fi
    else
        $DLLOG_WARNING "do not have the user:$user_name"
    fi
}

function dluser_create_user_and_set_password(){
    user_name=$1
    dluser_create_user $user_name
    dluser_set_user_password $user_name
}

if [ -n "$BASH_SOURCE" -a "$BASH_SOURCE" != "$0" ]
then
    echo
else
    echo "run self"
fi
