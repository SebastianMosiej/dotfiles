
"syn match  x
" Channel RP3-01 1 in WAIT_FOR_K28.7_IDLE state
" Channel RP3-01 1 in WAIT_FOR_K28.7_IDLE state. Previously not FRAME

syn match  xSrcClock_set   contained /handleSetClockSourcePortReq: set clock source to PortID: \d\{1,2\}/ 
"--------------------------------------------------------------------------------
syn match  xSWDL_completed contained /UOM_SWDL,\s*Component::triggerFilterSwUpdate$/

syn match  xAutonegotiation_start   contained /Autonegotiation is started/
syn match  xAutonegotiation_stop   contained /Autonegotiation for SFP\d is about to be stopped/

syn match xAutonegotiation_states contained /\<Autonegotiation\>.*/ contains=xAutodetection_start,xAutodetection_stop

syn match  xChipName contained /\<Gaia\d\>/

"Channel RP3-01 1 in UNSYNC state
syn match  xChannelInState contained /Channel RP3\(-01\)\? \d set TX to .*/ contains=xChannelsState,xPortName,xChipName
syn match  xChannelInState contained /Channel RP3\(-01\)\? \d in .* state.*/ contains=xChannelsState,xPortName,xChipName

 hi def link xSFP_connected Type
 hi def link xAutonegotiation_state MoreMsg
 hi def link xAutonegotiation_stop WarningMsg
 hi def link xProcedures Cursor
