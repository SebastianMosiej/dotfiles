
runtime! syntax/xRfCtrlParamId.vim 
runtime! syntax/xRfCtrlMsgType.vim 

syn match xRfCtrlMsgChained contained /\v([1-9]\/ 0)|(0\/ [1-9])/
syn match xRfCtrlMsgSeperator contained /|/
syn match xRfCtrlMsgOLSOff contained /0x[1289A][00]/
syn match xRfCtrlMsgOLSFrame contained /0x[1289A][34]/
syn match xRfCtrlMsgOLS contained /Port Status\[\] : 0x[A-Fa-f0-9]\{2\}/ contains=xRfCtrlMsgOLSFrame,xRfCtrlMsgOLSOff
syn region xRfCtrlMsgHeader oneline contained start=': Header : ' end="Path : 0x\x\{2,8\} " contains=xRfCtrlMsgType,xRfCtrlMsgTypeSet,xRfCtrlMsgTypeGet,xRfCtrlMsgTypeReset,xRfCtrlMsgTypeInd,xRfCtrlMsgTypeNack,xRfCtrlMsgChained
syn match xRfCtrlMsgHeaderReset contained /: Header : .*CtrlMsgType : \(\(0x0F\)\|\(0x10\)\) .*\Path : 0x\x\{2,8\} / contains=xRfCtrlMsgType,xRfCtrlMsgTypeSet,xRfCtrlMsgTypeGet,xRfCtrlMsgTypeReset
syn match xRfCtrlMsgI contained '\(in >>>\) '
syn match xRfCtrlMsgO contained '\(<<< out\) '
syn match xRfCtrlMsgPort contained 'Port : \zs0x\x\x\ze'
syn match xRfPortCtrl contained 'Port control : \zs00000111\ze'
syn match xRfPortCtrl contained 'Port control : \zs00001001\ze'
syn region xRfCtrlMsg oneline contained start='\(\(in >>>\)\|\(<<< out\)\) ' end='\($\|\(CRC : 0x\x\{4\}\)\)' contains=xRfCtrlMsgI,xRfCtrlMsgO,xRfCtrlMsgHeader,xRfCtrlParamId,xCtrlMsgSeperator,xRfCtrlMsgHeaderReset,xRfPortCtrl,xRfCtrlMsgOLS,xRfCtrlMsgPort
"syn region xCtrlMsg contained start='\[\d\] \(\(in >>>\)\|\(<<< out\)\) ' end='$' contains=xCtrlMsgHeader,xRfCtrlParamId,xCtrlMsgSeperator

	hi xRfCtrlMsgType term=bold ctermfg=3 guifg=Gold gui=underline guisp=Gold guibg=grey17
	hi xRfCtrlMsgTypeGet term=bold ctermfg=3 guifg=DarkGoldenrod gui=underline guisp=Gold guibg=grey17
	hi xRfCtrlMsgTypeInd term=bold ctermfg=3 guifg=IndianRed1 gui=underline guisp=Gold guibg=grey17
	hi xRfCtrlMsgTypeSet term=bold ctermfg=3 guifg=OrangeRed1 gui=underline guisp=Gold guibg=grey17
	hi xRfCtrlMsgTypeNACK term=bold ctermfg=3 guifg=Red1 gui=underline,bold guisp=Gold guibg=grey17
	hi xRfCtrlMsgTypeReset term=bold ctermfg=4 guifg=red1 gui=underline guisp=Gold guibg=grey10
	hi xRfCtrlParamId  term=bold ctermfg=3 guifg=Gold gui=underline guisp=Gold guibg=grey17
	hi xRfCtrlMsgHeader  term=bold ctermfg=3 guifg=Yellow gui=underline guisp=Gold
	hi xRfCtrlMsgHeaderReset  term=bold ctermfg=3 guifg=red1 gui=underline guisp=Yellow
	hi xRfCtrlMsgSeperator term=bold ctermfg=3 guifg=Gold gui=bold,underline guisp=Gold
	hi xRCtrlMsg        term=bold ctermfg=3 guifg=Gold 
	hi xRfCtrlMsgChained term=bold ctermfg=3 guifg=black guibg=Yellow  gui=underline guisp=Gold
	hi def link xRfCtrlMsgOLS    Normal
	hi def link xRfCtrlMsgOLSFrame Question
	hi def link xRfCtrlMsgOLSOff Constant
  hi def link xRfPortCtrl  Constant
  hi def link xRfCtrlMsgPort  Constant

  hi def link xRfCtrlMsgI Cursor
  hi def link xRfCtrlMsgO WildMenu

