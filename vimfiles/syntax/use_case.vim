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

syn match  xRowSeparator  contained /^=====$/
syn match  xEntryTitle  contained /^Use Case:$/
syn match  xEntryTitle  contained /^Actor:$/
syn match  xEntryTitle  contained /^Precondition:$/
syn match  xEntryTitle  contained /^Postcondition:$/
syn match  xEntryTitle  contained /^Trigger:$/
syn match  xEntryTitle  contained /^Main path:$/
syn match  xEntryTitle  contained /^Extensions:$/
syn match  xEntryTitle  contained /^Alternative path \d:$/
syn match  xEntryTitle  contained /^Description:$/

syn region xBulletList start=" \* " end="$" contained
syn region xOrderList start=" \d\{1,2\}\w*\. " end="$" contained

syn region xEntry start="^=====$" end="\ze^=====$" contains=xRowSeparator,xEntryTitle,xBulletList,xOrderList

hi def link xRowSeparator  Comment
hi def link xEntryTitle Special 
hi def link xBulletList ModeMsg
hi def link xOrderList ModeMsg
