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

syn match  xAssignmentTime   contained /,\zs\(\d\|\.\)\{1,40}\ze$/
syn match  xAssignmentValue  contained /\zs\(\w\|\s\)*\ze/ nextgroup=xAssignmentTime
syn match  xAssignmentName   contained /\v^\zs\w*\ze=/ nextgroup=xAssignmentValue
syn match  xAssignmentKeyword contained /\v^\zsscreenshot\ze/ nextgroup=xAssignmentTime
syn match  xComment          contained /\v^\/\/.*$/
syn match  xAssignment       contained /\v^\w*\=\w*.*$/ contains=xAssignmentName,xAssignmentValue,xAssignmentTime
syn match  xIncludedScenario contained /\v\s\zs<\w*>\ze/ 
syn match  xInclude          contained /\v^\s*include\s*.*$/ contains=xIncludedScenario

syn region xLogLineEntry start="\_^" end="$" contains=xComment, xAssignment,xInclude


  hi def link xComment          Comment
  hi def link xAssignment       Normal
  hi def link xAssignmentName   Special
  hi def link xAssignmentValue  Type
  hi def link xAssignmentTime   Type
  hi def link xInclude          Normal
  hi def link xIncludedScenario Type
