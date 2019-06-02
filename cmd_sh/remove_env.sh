#!/bin/bash
#####################################
## File name : remove_env.sh
## Create date : 2018-11-25 16:01
## Modified date : 2019-01-27 16:25
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

rm -rf $env_path
