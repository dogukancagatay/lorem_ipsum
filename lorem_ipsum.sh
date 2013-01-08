#!/bin/sh

if [ $# -eq 2 ] || [ $# -eq 3 ]; then
    OK=0
    if [ "$1" = "-w" ]; then
        LOREM_TYPE="words"
        OK=1
    fi
    if [ "$1" = "-p" ]; then
        LOREM_TYPE="paras"
        OK=1
    fi
    if [ "$1" = "-b" ]; then
        LOREM_TYPE="bytes"
        OK=1
    fi
    AMOUNT=$2
    START="yes"
    if [ $# -eq 3 ] && [ "$3"="-n" ]; then
        START="no"
    fi
    if [ $OK -eq 1 ]; then
        RAW_LIPSUM=$(curl -fsSkL "http://www.lipsum.com/feed/xml?amount=$AMOUNT&what=$LOREM_TYPE&start=$START")
        #delete before lipsum
        LIPSUM=${RAW_LIPSUM#*<lipsum>}
        #delete after lipsum
        LIPSUM=${LIPSUM%</lipsum>*}
        echo "$LIPSUM"
        exit 0
    fi
fi

