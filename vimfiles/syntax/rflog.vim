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
set conceallevel=3
runtime! syntax/xSubsystemsName.vim
runtime! syntax/xEventsNames.vim 
runtime! syntax/xRfCtrlMsg.vim 
runtime! syntax/xRfFZHJ.vim 
runtime! syntax/xRfREL3.vim 
runtime! syntax/xRfREL2.vim 
runtime! syntax/xRfRxTxStates.vim 
runtime! syntax/xRfFaults.vim 
runtime! syntax/xRfScheduling.vim 

syn match  xBlockingReq   contained /\(\(\s*\<operation:\s*update_parm,.*dist[Nn]ame: module,\s*parameters:\s*blocked\)\|\(BLOCK_\(UN\)\?BLOCKED\)\)/
syn match  xBlockingReq   contained /\s*\<operation:\s*update_parm,.*dist[Nn]ame: module,\s*parameters:\s*blocked/
syn match  xSrcClock_set  contained /setting clock source to link \d\{1,2\}/
syn match  xUnitType      contained /HW environment\s\zs.*\ze\s(/
syn match  xUnitType      contained /StartupComponent, HWID: \zs.*\ze$/
syn match  xUnitType      contained /Eeprom: Serial number\s*: \<\zs.*\ze\>/
syn match  xUnitType      contained /Serial number sent in ModuleReadyInd:\<\zs.*\ze\>\./

"--------------------------------------------------------------------------------
syn match  xPLL_lock       contained /newState=1 oldState=\d/
syn match  xPLL_lock       contained /PLL_LOCK is LOCKED/
syn match  xPLL_unsync     contained /newState=0 oldState=\d/
syn match  xPLL_unsync     contained /PLL_LOCK is UNSYNC/
syn match  xPLL_state      contained /monitorPllInterrupts\ *newState=\d oldState=\d/ contains=xPLL_lock,xPLL_unsync
syn match  xPLL_state      contained /PLL_LOCK is \<.*\>/ contains=xPLL_lock,xPLL_unsync
"--------------------------------------------------------------------------------
syn match  xSFP_state1     contained /SFP RX LOS secondary (channel\(:\)\? RP3-01 \d)/
syn match  xSFP_state1     contained /SFP RX LOS secondary activated (channel\(:\)\? RP3-01 \d)/
syn match  xSFP_state1     contained /SFP RX LOS activated (channel\(:\)\? RP3-01 \d)/
syn match  xSFP_state1     contained /SFP RX LOS (channel: RP3-01 \d)/
syn match  xSFP_state1     contained /SFP RX LOS activated repeated, handling interrupted/
syn match  xSFP_state1     contained /SFP RX LOS\s*not activated (channel RP3-01 \d).*/
syn match  xSFP_state1     contained /StateChange RX LOS inactivated (channel\(:\)\? RP3-01 \d)/
syn match  xSFP_state1     contained /SFP_LOS interrupt came for pId=\d signal=1/
syn match  xSFP_state1     contained /SFP_LOS state = 1/
syn match  xSFP_state0     contained /SFP RX LOS \(.* \)\?inactivated (channel\(:\)\? RP3-01 \d)/
syn match  xSFP_state0     contained /SFP RX LOS secondary\s*not activated - port is master (channel: RP3-01 \d)/
syn match  xSFP_state0     contained /SFP_LOS state = 0/
syn match  xSFP_state0     contained /SFP_LOS interrupt came for pId=\d signal=0/
syn match  xSFP_state0     contained /SFP RX LOS Secondary disabled .*/
syn match  xSFP_state      contained /SFP RX .*/  contains=xSFP_state0,xSFP_state1
syn match  xSFP_state      contained /SFP_LOS .*/ contains=xSFP_state0,xSFP_state1

syn match  xSFP_connected  contained /\<SFP\d_signal=1\>/
"syn match  xSFP_connected contained /StateChange RX LOS inactivated (channel\(:\)\? RP3-01 \d)/
syn match  xSFP_disconnected  contained /\<SFP\d_signal=0\>/
syn match  xSFP_connected  contained /SFP\d connected!/
syn match  xSFP_presence contained /\<SFP\d.*/ contains=xSFP_connected,xSFP_disconnected
"syn match  xProcedures contained /\<SoftResetManager\>/
"--------------------------------------------------------------------------------
syn match xReset  contained /startResetTimer - (Synchronization lost) Waiting\s*\d\{2,5\}\sms\sfor Optical Clock Port synchronization./
syn match xReset  contained /UOM_Reset,.*\(\(HardResetManager::resetProcedure started\)\|\(shutdownRouter\)\|\(ModifyStateHandler::sendRestartModule\)\)/
syn match xReset  contained /Rp3Ports::softReset SoftResetManager is active - sending notification/
syn match xReset  contained /\(ModifyStateHandler::sendRestartModule\)/
syn match xReset  contained /No synchronization on .*\<Connection State = 0. Ethernet enabled = 1\>/
syn match xReset  contained /Rp3Ports::hwReset - HW Reset/
syn match xResetStop contained /stopResetTimer (synchronization restored)/
syn match xResetStop contained /SoftResetManager, SoftReset was finished successfully./
syn match xSoftReset contained /\<SoftResetManagerHelperImp\>::\<.*\>()/
"--------------------------------------------------------------------------------
syn match  xThreadId          contained /\s\<[0-9A-F]\{-1,8}\>\s/ 
"syn match  RFTimestamp         contained /\(\d\d[:. ]\?\)\{6}\d\{2,3}\d\{-3,6}/ nextgroup=xThreadId
syn match  RFTimestampEnd      contained /\(\d\d[:. ]\?\)\{3}\d\{-3,6}Z\?>/ nextgroup=xThreadId
syn match  RFTimestampConceal  contained /\d\{4}-\d\d-\d\dT/ nextgroup=RFTimestampEnd
syn match  RFTimestampStart    contained /</ nextgroup=RFTimestampConceal
syn match  xDeviceName        contained /FRM_REL\d\s/ nextgroup=xTimeStampStart
syn match  xLineNr            contained /\_^\x\{-2,6}\s/ nextgroup=xDeviceName


syn region xLogData start="\_^" end=">\s\x\{1,7}\s" contained contains=xLineNr,xLineNr,xDeviceName,RFTimestampStart,RFTimestampConceal,RFTimestampEnd,xThreadId,xBTSCompName keepend

syn region xRouter_VDInf    contained start='Router_VD' end='$' keepend contains=xSFP_presence,xSFP_state,xSrcClock_set,xChannelInState,xPLL_state,xFZHJ,,xAutonegotiation_states,xFCB_reception,xClockSource,xFCB_sync

syn region xRouter_VDDbg    contained start='Router_VD' end='$' oneline

"lines with log entry (level, component and text)
syn region xEntryDbg start="DBG/" end="$" keepend contained contains=xSubsystemsName,xEventsNames,xRouter_VDDbg
syn region xEntryInf start="\(INF\|I\)\/" end="$" keepend contained contains=xSubsystemsName,xEventsNames,xRfCtrlMsg,xRouter_VDInf,xResetStart,xResetStop,xBlockingReq,xReset,xSWDL_completed,xUnitType,xSoftReset,xFault,xRfScheduling
syn region xEntryErr start="\v(ERR|(ERROR))\/" end="$" keepend contained contains=xSubsystemsName,xEventsNames
syn region xEntryWrn start="\(\(WRN\)\|\(WARN\)\|\(WARNING\)\)/" end="$" keepend contained contains=xSubsystemsName,xEventsNames, xSFP_state

syn region xLogLineEntry start="\_^" end="$" oneline contains=xLogData,xEntryDbg,xEntryInf,xEntryErr,xEntryWrn


    hi def link xLineNr		    Special
    hi def link xDeviceName   Type
    hi def link xLogData      Directory
    hi def link RFTimestamp        SpecialKey
    hi def link RFTimestampStart   SpecialKey
    hi def link RFTimestampConceal SpecialKey
    hi def link RFTimestampEnd     SpecialKey
    hi def link xThreadId          ModeMsg
    hi def link xBTSCompName  Type
  "
    hi def link xEntryInf       Comment
    hi def link xEntryDbg       Special
    hi def link xEntryWrn       TabLineFill
    hi def link xEntryErr       ErrorMsg
    hi def link xSubsystemsName LineNr
    hi def link xEventsNames    Question 
  "

    hi def link xRouter_VDInf 	SpecialKey
    "hi xRouter_VDInf 	term=bold cterm=bold ctermfg=4 guifg=DodgerBlue
    hi xRouter_VDDbg 	term=bold ctermfg=3 guifg=Coral
    hi def link xFZHJ xRouter_VDInf

    hi xSFP_state1 term=bold cterm=bold ctermfg=4 guifg=Blue guibg=firebrick1
    hi xSFP_state0 term=bold cterm=bold ctermfg=4 guifg=Blue guibg=green
    hi def link xSFP_disconnected xRouter_VDInf
    hi def link xSFP_presence xRouter_VDInf


    hi def link xPLL_lock xSFP_state0
    hi def link xPLL_unsync ErrorMsg 
    hi def link xFCB_reception xRouter_VDInf
    hi def link xFCB_rec_en xSFP_state0
    hi def link xFCB_rec_dis SpellBad
    hi def link xChannelInState xRouter_VDInf
    hi xChannelsState term=bold,underline cterm=bold,underline ctermfg=4 gui=underline guifg=PaleGreen2
    hi def link xPLL_state xRouter_VDInf
    hi xSrcClock_set  term=underline cterm=bold,underline ctermfg=4 gui=underline guifg=green3
    hi def link xReset xRfCtrlMsgHeaderReset
    hi def link xResetStart xRfCtrlMsgHeaderReset
    hi def link xResetStop xSrcClock_set
    hi def link xBlockingReq Question
    hi def link xSWDL_completed Question
    hi def link xUnitType Cursor
    hi def link xSoftReset Cursor
    hi def link xSFP_connected Type
    hi def link xFault xEntryInf
