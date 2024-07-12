#!/bin/bash

# Some prerequisites
export 'RBENV_ROOT'=/usr/local/src/rbenv
echo "export LANG=C.UTF-8" >>/etc/bashrc
echo "export PATH=$RBENV_ROOT/bin:$PATH" >>/etc/bashrc
