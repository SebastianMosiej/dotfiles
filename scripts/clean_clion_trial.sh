#!/bin/bash 
#-xv

echo "Parsing through CLion configuration files"
for file in `find ~/ -type d -iname '.CLion*'`
do
  if ls $file/config/eval/CLion*evaluation.key 1> /dev/null 2>&1; then
    for eval_key in `find $file/config/eval/CLion.*evaluation.key`
    do 
      echo "Removing CLion evaluation key '$eval_key'"
      rm $eval_key
    done
  fi
  if [ -e $file/config/options/options.xml ]; then
    echo "Removing CLion options evaluation entry"
    sed -i"" '/property name="evlsprt.*" value=.*/d' $file/config/options/options.xml
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
