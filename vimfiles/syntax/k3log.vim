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

runtime! syntax/k3log_actions.vim 
runtime! syntax/k3log_DistrBM_msg.vim

"syn region xTestCaseName contained start=/|"/ end=/"|/

"syn match  xLogText contained /\ .\{-}$/ 
syn match  xFileName contained /\(\w\)\{4,30}\.ttcn3:\d\{1,4} / nextgroup=xLogText
syn match  xComponentName contained /\(\w\ \)\{-3,20}\ / nextgroup=xFileName
syn match  xTimeStamp    contained /\_^\(\d\)\{8}T\d\{2,6\}\.\d\{2,6\}\ / nextgroup=xComponentName

syn region xLogText  start=" Log " end="$" contains=xK3Actions, xLogText
syn region xLogLineMsg start="Received\|Send" end="$" contains=xK3ActionsMsg

syn region xLogLineEntry start="\_^" end="$" contains=xTimeStamp, xComponentName, xFileName, xLogText, xK3Actions, xK3ActionsStart, xK3ActionsStop, xK3SpecLog, xK3DBM_msg, xK3DBM_fun, xLogText, xLogLineMsg


  hi def link xTimeStamp          ModeMsg
  hi def link xComponentName      Normal
  hi def link xFileName           LineNr
  hi def link xLogText            SpecialKey
  hi def link xLogLineMsg         Question
