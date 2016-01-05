#! /usr/bin/env bash
set -e

pushd "$(dirname "${BASH_SOURCE}")/../src" >/dev/null

stows=($(ls -d */))
for dir in "${stows[@]}"; do stow --adopt -t ~ "$dir"; done;

popd &>/dev/null

#echo ">> Installing from gem."
#gem install --user-install mdl

#echo ">> Installing from npm."
#npm install -g js-yaml jsonlint recess

#echo ">> Installing from pip."
#pip install neovim
#pip3 install neovim

echo ">> Installing vim plugins."
[ -n "$GOPATH" ] && export GOPATH=$HOME/go
vim !silent +PlugInstall +qall

echo ">> Pulling SSH pubkeys from github."
curl -s https://github.com/roboll.keys > ~/.ssh/authorized_keys
