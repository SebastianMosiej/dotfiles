#!/bin/bash 

FILE="$HOME/.nixnote/nixnote-1.conf"

if [[ ! -f $HOME/.nixnote/nixnote-1.conf ]]; then
  echo "Lack of nixnote configuration file"
  exit
fi

SECTION1="[ColumnHidden-Wide]"
SECTION2="[ColumnHidden-Narrow]"
COLUMNS_TO_HIDE=(altitude author dateCreated dateDeleted dateSubject hasEncryption hasTodo isDirty latitude lid longitude notebookLid notebook size thumbnail sourceApplication source sourceUrl tags reminderTime reminderTimeDone reminderOrder isPinned)
COLUMNS_TO_DISPLAY=(title dateUpdated)

for i in ${COLUMNS_TO_HIDE[@]}
do
  eval "sed -i'' s/$i=false/$i=true/ $FILE"
done
for i in ${COLUMNS_TO_DISPLAY[@]}; do
  eval "sed -i'' s/$i=true/$i=false/ $FILE"
done

eval "sed -i'' -e '/\[ColumnWidth-Wide\]/,/\[/ s|\(noteTableDateUpdatedPosition=\).*|\1140|' $FILE"
eval "sed -i'' -e '/\[ColumnWidth-Wide\]/,/\[/ s|\(noteTableTitlePosition=\).*|\1650|' $FILE"
#set -x      # activate debugging from here
#set +x      # stop debugging from here
