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
  set isk=@,48-57,-
else
  setlocal isk=@,48-57,-
endif

runtime! syntax/xSubsystemsName.vim
runtime! syntax/xEventsNames.vim 

syn match  xDate            /\(\(\d\d\)[\.\ :]\)\{5}\d\{6}/ contained
syn match  xHostName        /[0-9A-Za-z\._-]\{6,30}/ nextgroup=xDate contained
syn match  xLineNr          /\_^\x\x\ / nextgroup=xHostName contained


syn region xLogData start=/^/ end="\s\x\{-1,3}\s" contained contains=xLineNr,xHostName,xDate,xNR keepend

syn region xEntryDbg start="DBG/" end="$" contained contains=xSubsystemsName,xEventsNames
syn region xEntryInf start="\(\(INF\)\|\(I\)\)/" end="$" contained contains=xSubsystemsName,xEventsNames
syn region xEntryErr start="\(\(ERR\)\|\(ERROR\)\)/" end="$" contained contains=xSubsystemsName,xEventsNames
syn region xEntryWrn start="\(\(WRN\)\|\(WARN\)\|\(WARNING\)\)/" end="$" contained contains=xSubsystemsName,xEventsNames

syn region xLogLineEntry start="\_^" end="$" contains=xLogData,xEntryDbg,xEntryInf,xEntryErr,xEntryWrn keepend


  hi def link xLineNr         Question
  hi def link xHostName       Type 
  hi def link xDate           PreProc
  hi def link xEntryInf       Comment
  hi def link xEntryDbg       Special
  hi def link xEntryWrn       TabLineFill
  hi def link xEntryErr       DiffText
  hi def link xSubsystemsName LineNr
  hi def link xEventsNames    Question 
