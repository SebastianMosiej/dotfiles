#!/bin/bash
#-xv

for file in `find ~/ -type d -iname '.CLion*'`
do
  if [ -e $file/config/eval/CLion*evaluation.key ]; then
    echo "Removing CLion evaluation key"
    rm $file/config/eval/*
  fi
  if [ -e $file/config/options/options.xml ]; then
    echo "Removing CLion options evaluation entry"
    sed -i"" '/property name="evlsprt.*" value=.*/d' $file/config/options/options.xml
    #rm $file/config/options/options.xml
  fi
done
javaPref="~/.java/.userPrefs/jetbrains"
if [ -e $javaPref/clion/ ]; then
  echo "Removing Java preferences for CLion"
  rm -rf $javaPref/clion/
fi
if [ -e $javaPref/jetprofile/asset/cl/ ]; then
  echo "Removing Java preferences for CLion jetprofile"
  rm -rf $javaPref/jetprofile/asset/cl/
fi
rm -rf $javaPref/_*
