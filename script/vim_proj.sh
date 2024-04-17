#!/usr/bin/env bash

export VIM_PROJ_RPATH=.dedowsdi
export VIM_ROOT_TMP=/tmp/myvim
mkdir -p "$VIM_ROOT_TMP"
export VIM_PROJ_TMP=$(mktemp -p "$VIM_ROOT_TMP" -d "${PWD##*/}_$$_XXXXXX")

# start ctag server
mkdir -p "$VIM_PROJ_TMP/tag"
ctag_server -d "$VIM_PROJ_TMP/tag" -i 3 & CTAG_SERVER_PID=$!
trap 'kill $CTAG_SERVER_PID' EXIT

export CTAG_SERVER_PID
export CTAG_SERVER_LOG=$VIM_PROJ_TMP/tag/log
export CTAG_SERVER_PIPE=$VIM_PROJ_TMP/tag/pipe
