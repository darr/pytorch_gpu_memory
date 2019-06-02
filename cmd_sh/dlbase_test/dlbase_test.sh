#!/bin/bash
#####################################
## File name : dlbase_test.sh
## Create date : 2018-11-25 17:37
## Modified date : 2018-11-25 17:38
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
. dlgit_test.sh
. dllog_test.sh


function dlbase_test(){
    dlgit_test
    dllog_test
}

