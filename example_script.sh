#!/usr/bin/env bash

# saner programming env: these switches turn some bugs into errors
# set -e
# set -u
# set -o pipefail

./moss_downloader.sh -u "http://moss.stanford.edu/results/66335607/" -n "5" -o "Assignment_4"
./moss_downloader.sh -u "http://moss.stanford.edu/results/566792455/" -n "5" -o "Assignment_3"
./moss_downloader.sh -u "http://moss.stanford.edu/results/748129833/" -n "5" -o "Assignment_2"