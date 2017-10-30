" Vim syntax file
" Language:	MT Tester logs
" Quit when a (custom) syntax file was already loaded

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match xK3DBM_msg contained /\<IMUpdateNotification\>/
syn match xK3DBM_msg contained /\<BMUpdateNotification\>/
syn match xK3DBM_msg contained /\<BMConnectRequest\>/
syn match xK3DBM_msg contained /\<BMConnectResponse\>/
syn match xK3DBM_fun contained /\<DistributedBM.f_\w*\>/
syn match xK3DBM_fun contained /\<DistributedBmCommon.f_\w*\>/

hi def link xK3DBM_msg       DiffAdd
hi def link xK3DBM_fun       Identifier 
