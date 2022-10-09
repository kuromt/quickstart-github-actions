#!/bin/bash -l
set -ex

if [ -n $1 ]; then
    BASE=${GITHUB_BASE_REF}
else
    BASE=$1
fi
REMOTE=$2
PORT=$3
NBDIFF_WEB_EXPORTER_OPTIONS=$4

EXPORT_DIR="./artifacts"

mkdir $EXPORT_DIR
git diff $BASE $REMOTE --name-only| grep '.ipynb$'|xargs -L 1 nbdiff-web-exporter --port $PORT --export-dir $EXPORT_DIR $BASE $REMOTE 
