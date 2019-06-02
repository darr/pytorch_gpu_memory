#!/bin/bash
#####################################
## File name : run.sh
## Create date : 2018-11-26 11:19
## Modified date : 2019-05-20 23:43
## Author : DARREN
## Describe : not set
## Email : lzygzh@126.com
####################################

realpath=$(readlink -f "$0")
basedir=$(dirname "$realpath")
export basedir=$basedir/cmd_sh/
export filename=$(basename "$realpath")
export PATH=$PATH:$basedir
export PATH=$PATH:$basedir/dlbase
export PATH=$PATH:$basedir/dlproc
#base sh file
. dlbase.sh
#function sh file
. etc.sh
#. install_pybase.sh

kill -9 `ps -ef|grep main.py|grep -v grep|awk '{print $2}'`
kill -9 `ps -ef|grep defunct|grep -v grep|awk '{print$3}'`

function create_vir_env(){
    dlfile_check_is_have_dir $env_path

    if [[ $? -eq 0 ]]; then
        bash ./cmd_sh/create_env.sh
    else
        $DLLOG_INFO "$1 virtual env had been created"
    fi
}

create_vir_env

#bash ./cmd_sh/check_code.sh

#   source $env_path/py2env/bin/activate
#   deactivate
echo $env_path

source $env_path/py3env/bin/activate
#create_pybase
jupyter notebook

deactivate
