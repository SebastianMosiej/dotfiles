#!/bin/bash 

FILE="$HOME/.config/nixnote2/nixnote-1.conf"

if [[ ! -f $HOME/.config/nixnote2/nixnote-1.conf ]]; then
  echo "Lack of nixnote configuration file"
  exit
fi

COLUMNS_TO_HIDE=(altitude author dateCreated dateDeleted dateSubject hasEncryption hasTodo isDirty latitude lid longitude notebookLid notebook size thumbnail sourceApplication source sourceUrl tags reminderTime reminderTimeDone reminderOrder isPinned)
COLUMNS_TO_DISPLAY=(title dateUpdated)
COLUMNS_WIDTH=(noteTableLidPosition noteTableDateUpdatedPosition)
eval "sed -i'' '0,/ColumnWidth-Narrow/! {s/noteTableLidPosition=[0-9]*/noteTableLidPosition=50/1}' $FILE"
eval "sed -i'' '0,/ColumnWidth-Narrow/! {s/noteTableUpdatedPosition=[0-9]*/noteTableUpdatedPosition=150/1}' $FILE"
eval "sed -i'' '0,/ColumnWidth-Narrow/! {s/noteTableTitlePosition=[0-9]*/noteTableTitlePosition=150/1}' $FILE"
eval "sed -i'' '0,/ColumnWidth-Narrow/! {s/noteListWidth=[0-9]*/noteListWidth=330/1}' $FILE"

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
