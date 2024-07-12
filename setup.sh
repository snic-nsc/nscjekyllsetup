#!/bin/bash

cd /usr/local/src
git clone https://github.com/sstephenson/rbenv.git rbenv
pushd rbenv
git checkout v1.3.0
popd
git clone https://github.com/sstephenson/ruby-build.git rbenv/plugins/ruby-build
pushd rbenv/plugins/ruby-build
git checkout d8f64002c941a76fc4a17a68338717be019c1457

export PATH=/usr/local/src/rbenv/bin:$PATH
export RBENV_ROOT=/usr/local/src/rbenv
eval "$(rbenv init -)"
rbenv install 3.0.7
rbenv global 3.0.7
gem install -v 3.9.4 jekyll
gem install kramdown-parser-gfm
gem install webrick
##Optional
#Install a secondary ruby environment and deploy a second jekyll here.
rbenv install 3.3.2
rbenv global 3.3.2
gem install -v 4.3.3 jekyll
gem install kramdown-parser-gfm
gem install webrick
chmod -R ugo+rx /usr/local/src/rbenv
