

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


syn match xKanziNames contained /\vapp_ivi_.{-}>/
syn match xKanziNames contained /IVI_.*\>/

syn match xCloseScreen contained /\vclose\s*\<?-\>?\s*.*/ nextgroup=xScreenName
syn match xOpenScreen contained /\vopen\s*\<?-\>?\s*.*/ nextgroup=xScreenName

syn match  xEntryPerfTime  /\v\|-\>\s\zs0s\d{3}\.\d{3}\ze/ contained
syn match  xEntryType  /\v(Start)|(Total)/ contained
syn match  xEntryTime     /\v(\d\d[:.]){2}\d{6}/  nextgroup=xLogLevel contained

syn region xLogLineEntry start="^" end="$" contains=xEntryTime,xEntryType,xEntryPerfTime,xOpenScreen,xCloseScreen,xScreenName,xKanziNames

  hi def link xEntryTime      PreProc
  hi def link xEntryType      Question
  hi def link xEntryPerfTime  LineNr
  hi def link xOpenScreen     Question
  hi def link xCloseScreen    Constant
  hi def link xKanziNames     Special
