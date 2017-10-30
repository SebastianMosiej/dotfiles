
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


syn match xCloseScreen contained /\vclose\s*\<?-\>?\s*<.*>/
syn match xOpenScreen contained /\vopen\s*[<]?-[>]?\s*<.*>/
syn match xPerformanceTotal contained /\v\[\zs\d*\.\d*\ze\].*\[Total\]/

syn region xEntryErr start=" \<ERROR\> " end="$" contained contains=xSubsystemsName,xEventsNames
syn region xEntryWrn start=" \<WARN\> " end="$" contained contains=xSubsystemsName,xEventsNames
syn region xEntryDbg start=" \<DEBUG\> " end="$" contained contains=xSubsystemsName,xEventsNames
syn region xEntryPerformance start=" \<DEBUG\>.*{Infotainment.Performance}" end="$" contained contains=xPerformanceTotal
syn region xEntryInf start=" \<INFO\> " end="$" contained contains=xSubsystemsName,xEventsNames
syn region xEntryScreenOpenClose start=" \<INFO\>.*{UICockpitServerIVI.ScreenTiming}" end="$" contained contains=xOpenScreen,xCloseScreen keepend

syn match  xEntryTime     /\v(\d\d[:.]){1,3}\d\d\d/  nextgroup=xLogLevel contained

syn region xLogLineEntry start="^" end="$" contains=xEntryTime,xEntryErr,xEntryWrn,xEntryDbg,xEntryInf,xEntryScreenOpenClose,xEntryPerformance

  hi def link xEntryTime      PreProc
  hi def link xEntryScreenOpenClose        Directory
  hi def link xEntryInf       Comment
  hi def link xEntryDbg       Special
  hi def link xEntryPerformance Special
  hi def link xPerformanceTotal Statement
  hi def link xEntryWrn       TabLineFill
  hi def link xEntryErr       DiffText
  hi def link xOpenScreen     Question
  hi def link xCloseScreen    Constant


