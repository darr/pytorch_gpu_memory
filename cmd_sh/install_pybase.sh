#!/bin/bash
#####################################
## File name : install_pybase.sh
## Create date : 2018-11-25 16:03
## Modified date : 2019-03-18 15:58
## Author : DARREN
## Describe : not set
## Email : lzygzh@126.com
####################################

realpath=$(readlink -f "$0")
export basedir=$(dirname "$realpath")
export filename=$(basename "$realpath")
export PATH=$PATH:$basedir/dlbase
export PATH=$PATH:$basedir/dlproc
#base sh file
. dlbase.sh
#function sh file
. etc.sh

pybase_path="../pybase"

function dlgit_down_pybase(){
    down_url="https://github.com/darr/pybase.git"
    folder=$pybase_path
    dlgit_clone_git $down_url $folder
}

function dlgit_rm_pybase(){
    rm -rf $pybase_path
}

function create_pybase(){
    dlfile_check_is_have_dir $pybase_path

    if [[ $? -eq 0 ]]; then
        dlgit_down_pybase
    else
        $DLLOG_INFO "$1 pybase have been created"
#        dlgit_rm_pybase
    fi
    cd $pybase_path
    pwd
    bash ./set_up.sh
    cd -
}

source $env_path/py3env/bin/activate
create_pybase
deactivate
