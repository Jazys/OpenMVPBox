#!/bin/bash

FILENAME=$1
ORIGINAL_STRING=$2
NEW_STRING=$3

if [ $# -ne 3 ]; then
    echo "Please verify the number of arguments passed. Three arguments are required."
    exit 1
fi

sed -i 's/${ORIGINAL_STRING}/${NEW_STRING}/g' $FILENAME
