" Vim syntax file
" Language:	MT Tester logs
" Quit when a (custom) syntax file was already loaded

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" MOST important - else most of the keywords wont work!
if version < 600
  set isk=@,48-57,-,_
else
  setlocal isk=@,48-57,-,_
endif

runtime! syntax/xSubsystemsName.vim
runtime! syntax/xEventsNames.vim 

syn region xEntryErr start="\(\(ERR\)\|\(ERROR\)\)/" end="$" contained contains=xSubsystemsName,xEventsNames
syn region xEntryWrn start="\(\(WRN\)\|\(WARN\)\|\(WARNING\)\)/" end="$" contained contains=xSubsystemsName,xEventsNames
syn region xEntryDbg start="\(\(DBG\)\|\(D\)\)/" end="$" contained contains=xSubsystemsName,xEventsNames
syn region xEntryInf start="\(\(INF\)\|\(I\)\)/" end="$" contained contains=xSubsystemsName,xEventsNames

"""""
syn match  xTimeStampEnd    /\>/ contained nextgroup=xEntryDataDbg,xEntryDataErr,xEntryWrn,xEntryDataInf
syn match  xTimeStamp       /\(\d\{1,2}[:. ]\?\)\{1,5}/ contained nextgroup=xTimestampEnd 
syn match  xTimeStampStart  /</ contained nextgroup=xTimestamp 
syn match  xTickEnd         /\]/ nextgroup=xTimeStampStart contained
syn match  xTickCount       /\d\{-1,8}/  nextgroup=xTickEnd contained
syn match  xTickStart       /\[/  nextgroup=xTickCount contained
syn match  xHostName        /[0-9A-Za-z_]\{-6,10}:/ nextgroup=xTickStart contained
syn match  xLineNr          /\_^\x\x\s/ nextgroup=xHostName contained


syn region xLogData start="^" end="O&M\s" contained contains=xLineNr,xHostName,xTickStart,xTickCount,xTickEnd,xTimeStampStart,xTimeStamp,xTimeStampEnd,xOAMKeyword
syn region xLogLineEntry start="^" end="$" contains=xLogData,xEntryInf,xEntryDbg,xEntryWrn,xEntryErr


  hi def link xLineNr         PreProc
  hi def link xHostName       PreProc
  hi def link xOAMKeyword     PreProc
  hi def link xTickCount      Special 
  hi def link xTickStart      ModeMsg
  hi def link xTickEnd        ModeMsg
  hi def link xTimeStampStart ModeMsg
  hi def link xTimeStampEnd   ModeMsg
  hi def link xTimeStamp      Constant
  hi def link xEntryInf       Comment
  hi def link xEntryDbg       Special
  hi def link xEntryWrn       TabLineFill
  hi def link xEntryErr       DiffText
  hi def link xEntryDataInf   Comment
  hi def link xEntryDataDbg   Special
  hi def link xEntryDataErr   DiffText
  hi def link xEntryDataWrn   TabLineFill
  hi def link xSubsystemsName LineNr
  hi def link xEventsNames    Question 
  
