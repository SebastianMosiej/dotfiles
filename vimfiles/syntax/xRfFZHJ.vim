syn match  xSrcClock_set   contained /setting clock source to link \d\{1,2\}/
" REL2
syn match  xSrcClock_set   contained /handleSetClockSourcePortReq: set clock source to PortID: \d\{1,2\}/ 
syn match  xSFP_state1     contained /SFP_LOS state = 1/
syn match  xSFP_state0     contained /SFP_LOS state = 0/
syn match  xSFP_connected  contained /SFP\d connected!/
syn match  xSFP_disabled   contained /SFP RX LOS disabled (channel: RP3-01 \d)/
syn match  xSFP_disabled   contained /SFP RX LOS Secondary disabled (channel: RP3-01 \d)/

syn match  xPLL_lock       contained /PLL_LOCK is LOCKED/
syn match  xPLL_unsync     contained /PLL_LOCK is UNSYNC/

syn match  xChannelsState  contained /UNSYNC/
syn match  xChannelsState  contained /WAIT_FOR_K28\.7_IDLE/
syn match  xChannelsState  contained /WAIT_FOR_K28\.5_IDLE/
syn match  xChannelsState  contained /WAIT_FOR_FRAME_SYNC_T/
syn match  xChannelsState  contained /FRAME_SYNC/

syn match  xChannelInState contained /Channel RP3\(-01\)\+ \d in .* state/ contains=xChannelsState

syn match  xFZHJ contained /Router_VD .*/ contains=xSFP_connected,xSFP_disabled

	hi xSFP_state1 term=bold cterm=bold ctermfg=4 guifg=Blue guibg=firebrick1
	hi xSFP_state0 term=bold cterm=bold ctermfg=4 guifg=Blue guibg=green
	hi def link xPLL_lock xSFP_state0
	hi def link xPLL_unsync ErrorMsg 
	"hi xSrcClock_set  term=underline cterm=bold,underline ctermfg=4 gui=underline guifg=green3
"  hi def link xSFP_connected xSrcClock_set
	"hi def link xChannelInState xRouter_VDInf
	hi xChannelsState term=bold,underline cterm=bold,underline ctermfg=4 gui=underline guifg=PaleGreen2

