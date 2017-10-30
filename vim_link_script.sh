#!/bin/bash


if [ ! -e ~/.vim ]; then
  echo 'Not exisitng .vim directory. Creating one'
  mkdir ~/.vim
fi

#$1 1 - use vimfiles as source_dir
#   0 - use current dir as source dir
#$2 under what name linked object
#$3 name of file (used when different then $2)
function testSymLink()
{
  #set destination dir
  destination_dir=~/$2
  xpath=${destination_dir%/*}
  #echo '  Destination dir '$xpath
  if [ -n $xpath -a ! -e $xpath ];then
      echo '  Creating '$xpath' directory'
      mkdir -p $xpath
  fi

  #set target dir
  if [ $1 -eq 1 ];then
    target_dir='vimfiles/'
  else
    target_dir=''
  fi

  #test if target file has different name
  if [ -z "$3" ]; then
    target_dir=$target_dir"${2/.vim\//}"
  else
    target_dir=$target_dir"${3/.vim\//}"
  fi
  target_dir=`readlink -f $target_dir`

  if ! [ -L $destination_dir ]; then
    echo '  Linking "'$destination_dir'" to "'$target_dir'"'
    ln -s $target_dir $destination_dir
  else
    echo '  '$destination_dir ' exists'
  fi
}

echo '== Testing .vimrc'
testSymLink 1 .vimrc vimrc
echo '== Testing custom_functions'
testSymLink 1 .vim/custom_functions.vim
echo '== Testing bundle_configuration'
testSymLink 1 .vim/bundle_configuration.vim
echo '== Testing detecting_tags'
testSymLink 1 .vim/detecting_tags.vim
echo '== Testing greps'
testSymLink 1 .vim/greps.vim

echo '== Testing .vim/filetype.vim'
testSymLink 1 .vim/filetype.vim
echo '== Testing .vim/scripts'
testSymLink 1 .vim/scripts.vim

echo '== Testing syntax directory'
testSymLink 1 .vim/syntax
echo '== Testing plugin directory'
testSymLink 1 .vim/plugin
echo '== Testing bundle/Vundle.vim directory'
testSymLink 1 .vim/bundle/Vundle.vim
