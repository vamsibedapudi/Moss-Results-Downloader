#!/usr/bin/env bash

# saner programming env: these switches turn some bugs into errors
# set -e
# set -u
# set -o pipefail

./moss-downloader.sh -u "http://moss.stanford.edu/results/<number>/" -n "5" -o "moss_result_dir_1"
./moss-downloader.sh -u "http://moss.stanford.edu/results/<number>/" -n "10" -o "moss_result_dir_2"
./moss-downloader.sh -u "http://moss.stanford.edu/results/<number>/" -n "20" -o "moss_result_dir_3"