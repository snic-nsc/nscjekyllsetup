#!/bin/bash
cd /mnt
source /usr/local/src/nscjekyllsetup/rubyenv
jekyll build;
exit $?;
