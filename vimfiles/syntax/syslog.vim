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
runtime! syntax/xEventsNames.vim 
runtime! syntax/xRfCtrlMsg.vim 
"runtime! syntax/xRfFZHJ.vim 
"runtime! syntax/xRfREL3.vim 
"runtime! syntax/xRfREL2.vim 


syn match  xSrcClock_set   contained /setting clock source to link \d\{1,2\}/
" REL2
syn match  xChannelsState  contained /IDLE/
syn match  xChannelsState  contained /IDLE_REQ/
syn match  xChannelsState  contained /IDLE_ACK/
syn match  xChannelsState  contained /WAIT_FOR_K28\.\?7_IDLES\?/
syn match  xChannelsState  contained /WAIT_FOR_K28\.\?5_IDLES\?/
syn match  xChannelsState  contained /WAIT_FOR_FRAME_SYNC_T/
syn match  xChannelsState  contained /WAIT_FOR_SEED/
syn match  xChannelsState  contained /[Oo]ff/
syn match  xChannelsState  contained /[Ii]dle/
"syn match  xChannelsState  contained /frame/

syn match  xChannelsState  contained /ETxChnlSyncStatus_Idle/
syn match  xChannelsState  contained /ETxChnlSyncStatus_Frame/
syn match  xChannelsState  contained /ETxChnlSyncStatus_Off/
syn match  xChannelsState  contained /unknown \<.*\>/
syn match  xChannelFrame contained /FRAME_SYNC\>/
syn match  xChannelFrame contained /[Ff]rame\>/
syn match  xChannelUnsync contained /UNSYNC\>/
syn match  xChannelUnsync contained /Unsync\>/
syn match  xChannelUnsync contained /[Oo]ff\>/

syn match  xPortName contained /RP3-01 \d/
syn match  xChannelInState contained /\vASICService -- (TR.*)*[Pp]ort ..\d{1,2}, OIC\d.* [RT]xState is.*/ contains=xChannelsState,xPortName,xChannelFrame,xChannelUnsync
syn match  xChannelInState contained /\[OptSynchronizer\]\[[SB]B*MOD_L-\d\|CONNECTOR_L-\d\]\[linkId \d\] [RT]X is \<.*\>/ contains=xChannelsState,xPortName,xChannelFrame,xChannelUnsync
syn match  xChannelInState contained /\(Channel\|Link\) RP3-01 \d TX set to \<.*\>/ contains=xChannelsState,xPortName,xChannelFrame,xChannelUnsync
syn match  xChannelInState contained /\(Channel\|Link\) RP3-01 \d \(RX \)\?in \<.*\> state/ contains=xChannelsState,xPortName,xChannelFrame,xChannelUnsync 
syn match  xChannelInState contained /\(Channel\|Link\) RP3-01 \d TX set \<.*\>/ contains=xChannelsState,xPortName,xChannelFrame,xChannelUnsync 
syn match  xChannelInState contained /Opt Link \d TX changed to \<.*\> state/ contains=xChannelsState,xPortName,xChannelFrame,xChannelUnsync 
syn match  xCtrlMsgParamValues contained /\v\zs(\x{1,2}\s?){8}\ze($|. MsgID)/
syn match  xCtrlMsgParamType contained /\v( \x{1,2}){4}\s\zs\x{1,2}\ze.*/ contains=xCtrlMsgParamValues nextgroup=xCtrlMsgParamValues
syn match  xCtrlMsgType contained /\v((Data:)|((\<\<\<))|(\>\>\>)) (\x{1,2} ){3}\zs\x{1,2}\ze/ nextgroup=xCtrlMsgParamType
syn match  xCtrlMsgOut contained /\v\zs((Sending control message)|(\(in\)))\ze/ nextgroup=xCtrlMsgType
syn match  xCtrlMsgIn  contained /\v\zs((Received control message)|(\(out\)))\ze/ nextgroup=xCtrlMsgType
syn match  xCtrlMsg contained /\v((Sender|Dispatcher).*Rp3CtrlMsg).* ((\>\>\>)|(\<\<\<)).*$/ contains=xCtrlMsgType,xCtrlMsgOut,xCtrlMsgIn,xCtrlMsgParamType,xCtrlMsgParamValues
syn match  xCtrlMsg contained /\v(Sending|Received) control message (from|to) RP3-01 \d,.*$/ contains=xCtrlMsgType,xCtrlMsgOut,xCtrlMsgIn,xCtrlMsgParamType,xCtrlMsgParamValues
syn match  xCtrlMgs contained /\v((R.Sender|Dispatcher)\[OIC.\]: Rp3CtrlMsg \((out|in)\) (\>\>\>|\<\<\<)) .*/ contains=xCtrlMsgType,xCtrlMsgOut,xCtrlMsgIn,xCtrlMsgParamType,xCtrlMsgParamValues
"--------------------------------------------------------------------------------
runtime! syntax/xSubsystemsName.vim

syn match  xVal           contained /\s\<[0-9A-F]\{-1,7}\>\s/ 
syn match  xTimeStampSep  contained /[TZ.:-]/ 
"syn match  xTimeStamp2    contained /\(\d\{2}[.:]\)\{3}\d\{3,6}/ nextgroup=xTimeStampSep
"syn match  xTimeStamp2    contained /\(\d\{2}[.:]\)\{3}\d\{3,6}/ nextgroup=xTimeStampSep
"syn match  xTimeStamp1    contained /\(\d\{2,4}-\?\)\{3}/ nextgroup=xTimeStampSep
syn match  xTimeStamp1    contained /\(\d\{2,6}\)/
syn match  xTimeStamp     contained /<.*>/ contains=xTimeStamp1,xTimeStamp2,xTimeStampSep nextgroup=xHostIpStart
syn match  xDeviceName    contained /FRM_REL[1-3]\ / nextgroup=xTimeStamp
syn match  xDeviceName    contained /FCT-\x\{0,4\}.*?\s/ nextgroup=xTimeStamp
syn match  xLineNr        contained /\_^\x\{-2,6}\ / nextgroup=xDeviceName


syn region xRouter_VDInf    contained start='Router_VD' end='$' keepend contains=xSFP_presence,xSFP_state,xSrcClock_set,xChannelInState,xPLL_state,xFZHJ
syn region xRouter_VDDbg    contained start='Router_VD' end='$' oneline


"lines with log entry (level, component and text)
syn region xEntryDbg start="\vDBG\/" end="$" keepend contained contains=xSubsystemsName,xEventsNames,xRouter_VDDbg
syn region xEntryInf start="\v(INF|I\/)/" end="$" keepend contained contains=xCtrlMsg,xSubsystemsName,xEventsNames,xRfCtrlMsg,xRouter_VDInf,xChannelInState
syn region xEntryErr start="\v(ERR|(ERROR))\/" end="$" keepend contained contains=xSubsystemsName,xEventsNames
syn region xEntryWrn start="\v((WRN)|(WARN)|(WARNING))\/" end="$" keepend contained contains=xSubsystemsName,xEventsNames
syn region xLogData start="\_^" end="\s\(\x\{1,2\}\s\)\?\ze\v(INF|DBG|WRN|ERR)\/" contained contains=xLineNr,xDeviceName,xTimestamp,xVal,xBTSCompName keepend

syn region xLogLineEntry start="\_^" end="$" oneline contains=xLogData,xEntryDbg,xEntryInf,xEntryErr,xEntryWrn


  hi def link xLineNr		    Special
	hi def link xDeviceName   Type
  hi def link xLogData      Directory
  hi def link xTimeStamp1   PreProc
  hi def link xTimeStamp2   PreProc
  "hi def link xTimeStampSep Constant
  hi def link xVal          ModeMsg
  hi def link xBTSCompName  Type
"
  hi def link xEntryInf       Comment
  hi def link xEntryDbg       Special
  hi def link xEntryWrn       TabLineFill
  hi def link xEntryErr       DiffText
  hi def link xSubsystemsName LineNr
  hi def link xEventsNames    Question 
"
	hi xRouter_VDInf 	term=bold cterm=bold ctermfg=4 guifg=DodgerBlue
	hi xRouter_VDDbg 	term=bold ctermfg=3 guifg=Coral
  hi def link xFZHJ xRouter_VDInf

	hi xSFP_state1 term=bold cterm=bold ctermfg=4 guifg=Blue guibg=firebrick1
	hi xSFP_state0 term=bold cterm=bold ctermfg=4 guifg=Blue guibg=green
  hi def link xSFP_disconnected xRouter_VDInf
  hi def link xSFP_presence xRouter_VDInf


	hi def link xPLL_lock xSFP_state0
	hi def link xPLL_unsync ErrorMsg 
	hi def link xChannelInState xRouter_VDInf
	hi def link xChannelFrame Cursor
	hi def link xChannelUnsync WarningMsg
	hi xChannelsState term=bold,underline cterm=bold,underline ctermfg=4 gui=underline guifg=PaleGreen2
  hi def link xPLL_state xRouter_VDInf
	hi xSrcClock_set  term=underline cterm=bold,underline ctermfg=4 gui=underline guifg=green3

  hi def link xCtrlMsgIn Cursor
  hi def link xCtrlMsgOut WildMenu
  " hi def link xCtrlMsgType StatusLine
  hi def link xCtrlMsgType LineNr
  hi def link xCtrlMsgParamType LineNr
  hi def link xCtrlMsgParamValues StatusLine
  hi def link xCtrlMsg  xEntryInf
