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

syn match xResolvedRejection /^x\s*\<rejected\>.*$/
syn match xUnresolvedRejection /^>\s*\<rejected\>.*$/

hi def link xResolvedRejection Question
hi def link xUnresolvedRejection Search

