" Vim syntax file
" Language:	MT Tester logs
" Quit when a (custom) syntax file was already loaded

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match xK3ActionsStart contained /\<Start timer\>/
syn match xK3ActionsStop contained /\<Stop timer\>/
syn match xK3Actions contained /\<Log\>/
syn match xK3ActionsMsg contained /\<Send\>/
syn match xK3ActionsMsg contained /\<Received\>/
syn match xK3ActionsStart contained /\<Waiting for\>/
syn match xK3ActionsStart contained /\<Waiting for component\>/
syn match xK3ActionsStart contained /\<Component start\>/
syn match xK3ActionsStop contained /\<Component Finished\>/
syn match xK3ActionsStart contained /\<Message Queued\>/
syn match xK3ActionsStop contained /\<Function Leave\>/
syn match xK3ActionsStart contained /\<Function Enter\>/
syn match xK3ActionsStart contained /\<Default activated\>/
syn match xK3ActionsStop contained /\<Timeout\>/
syn match xK3ActionsStart contained /\<New verdict\>/

syn match xK3SpecLog contained /\<EndTestCase received\>/

hi def link xK3ActionsStart  Question 
hi def link xK3ActionsMsg    Question 
hi def link xK3ActionsStop   MoreMsg 
hi def link xK3Actions       Type 
hi def link xK3SpecLog       WarningMsg
