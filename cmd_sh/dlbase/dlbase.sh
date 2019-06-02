#!/bin/bash
if [ "$dlbase" ]; then
    return
fi

export dlbase="dlbase.sh"

. dllog.sh
. dlfile.sh
. dlgit.sh
. dlroot.sh
. dlboot.sh
