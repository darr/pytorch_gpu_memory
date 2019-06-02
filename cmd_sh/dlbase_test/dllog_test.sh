#!/bin/bash
#####################################
## File name : dllog_test.sh
## Create date : 2018-11-25 17:32
## Modified date : 2018-11-25 17:37
## Author : DARREN
## Describe : not set
## Email : lzygzh@126.com
####################################

realpath=$(readlink -f "$0")
basedir=$(dirname "$realpath")
export basedir=$basedir/../
export filename=$(basename "$realpath")
export PATH=$PATH:$basedir/dlbase
export PATH=$PATH:$basedir/dlproc
#base sh file
. dlbase.sh
#function sh file

function dllog_log_test(){
    $DLLOG_DEBUG "调试 debug"
    $DLLOG_INFO "信息 info"
    $DLLOG_WARNING "警告 warning"
    $DLLOG_ERROR "错误 error"
}

function dllog_test(){
    dllog_log_test
}

dllog_test
