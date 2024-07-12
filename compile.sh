#!/bin/bash
cd /mnt
source /usr/local/src/nscjekyllsetup/rubyenv $1
export LANG=C.UTF-8
jekyll build;
exit $?;
