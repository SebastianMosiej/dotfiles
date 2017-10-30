#!/bin/bash

apt-get install build-essential cmake plantuml gdb -yqq

add-apt-repository -r "deb http://apt.llvm.org/jessie/ llvm-toolchain-jessie-4.0 main"
add-apt-repository "deb http://apt.llvm.org/jessie/ llvm-toolchain-jessie-4.0 main"
wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -

apt-get update -qq
apt-get install python-dev python-pip python3-dev python3-pip tmux xclip -yq
apt-get install neovim -yq
apt-get install exuberant-ctags libboost1.5* -yq


apt-get install clang-4.0 clang-4.0-doc libclang-common-4.0-dev libclang-4.0-dev libclang1-4.0 libclang1-4.0-dbg libllvm-4.0-ocaml-dev libllvm4.0 libllvm4.0-dbg lldb-4.0 llvm-4.0 llvm-4.0-dev llvm-4.0-doc llvm-4.0-examples llvm-4.0-runtime clang-tidy-4.0 clang-format-4.0 python-clang-4.0 lldb-4.0-dev 

run_script_as_user $1 "../vim_link_script.sh"
#runuser -l $1 -c "cd ~/vim_developer_enviroment;chmod a+x vim_link_script.sh; ./vim_link_script.sh"
runuser -l $1 -c "ln -s $SCRIPTS_DIR/../tmux.conf .tmux.conf"
runuser -l $1 -c "ln -s ~/.vim ~/.config/nvim; ln -s ~/.vimrc ~/.config/nvim/init.vim"

runuser -l $1 -c "ln -s $SCRIPTS_DIR/../ctags ~/.ctags"

