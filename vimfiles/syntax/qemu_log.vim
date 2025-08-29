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

syn match  xLogLevel  contained /\<DEBUG\>/
syn match  xLogLevel  contained /\<TRACE\>/
syn match  xLogLevel  contained /\<INFO\>/
" #syn keyword xLogLevel contained TRACE INFO DEBUG
syn match  xComponentName contained /\t\([A-Za-z0-9._-]\)\{3,60}\t/ nextgroup=xFileName
syn match  xTimeStamp    contained /\_^\(\(\d\)\{2,9}[- :.]\?\)\{3,7}/ nextgroup=xComponentName
syn region xLogLineEntry start="\_^" end="$" contains=xTimeStamp, xComponentName, xLogText, xLogLevel


