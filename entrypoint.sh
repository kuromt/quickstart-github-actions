#!/bin/sh -l
set -ex

BASE=$1
REMOTE=$2
PORT=$3
NBDIFF_WEB_EXPORTER_OPTIONS=$4

EXPORT_DIR="./artifacts"

mkdir $EXPORT_DIR
git diff origin/main diff-notebooks --name-only| grep 'ipynb$'|xargs -L 1 nbdiff-web-exporter --port $PORT --export-dir $EXPORT_DIR $BASE $REMOTE 
