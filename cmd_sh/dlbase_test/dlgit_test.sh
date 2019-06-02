#!/bin/bash
#####################################
## File name : dlgit_test.sh
## Create date : 2018-11-25 16:56
## Modified date : 2019-01-27 22:21
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

function dlgit_down_test(){
    down_url="https://github.com/matplotlib/matplotlib.git"
    folder="/tmp/matplotlib"
    dlgit_clone_git $down_url $folder
    rm -rf /home/liuzy/matplotlib
}

function dlgit_down_test2(){
    down_url="https://github.com/darr/pybase.git"
    folder="./pybase"
    dlgit_clone_git $down_url $folder
    rm -rf ./pybase
}

function dlgit_test(){
    dlgit_down_test2
}

dlgit_test
