
syn match  xFCB_rec_en  contained /Enabled/
syn match  xFCB_rec_dis contained /Disabled/
syn match  xFCB_reception contained /Channel RP3-01 \d: FCB reception .*/ contains=xFCB_rec_en,xFCB_rec_dis
syn match  xFCB_sync contained /GaiaToGaiaFcbSync procedure started/
syn match  xFCB_sync contained /GaiaToGaiaFcbSync procedure finished/

syn match  xSFP_connected contained /SFP\d connected/

syn match  xChipName1 contained /\<Gaia0\>/
syn match  xChipName2 contained /\<Gaia1\>/
syn match  xChipName3 contained /\<Gaia2\>/
syn match  xChipName  contained /\<Gaia\d\>/ contains=xChipName1,xChipName2,xChipName3
syn match  xPortName  contained /RP3-01 \d/
syn match  xClockSource contained /NetworkModeInit40::ClockSource::run()/
syn match  xClockSource contained /GAIA NAMES : .*$/
syn match  xClockSource contained /\<LinkBreakHandler\>/
syn match  xClockSource contained /\<SoftResetManager\>/
syn match  xClockSource contained /\<Connection State = \d. Ethernet enabled = \d\>/


syn match xAutonegotiation_startClock contained /Rp3ClockLinkSynchronizationAutoNegotiation*::synchronize port=\d, linkRate=\d/
syn match xAutonegotiation_startSec contained /Rp3SecondaryLinkSynchronization*::synchronize port=\d, linkRate=\d/
syn match xAutonegotiation_start contained /Rp3\(\(Secondary\)\|\(Clock\)\)LinkSynchronization\(AutoNegotiation\)*::onLinkRateChangeTimer port=\d, new link rate=\d/
syn match xAutonegotiation_start contained /Starting auto-negotiation now.../
syn match xAutonegotiation_start contained /Starting basic synchronization now.../
syn match xAutonegotiation_stop contained /Rp3ClockLinkSynchronizationAutoNegotiation::onHandleFrameSync$/
"syn match xAutonegotiation_states contained /Rp3ClockLinkSynchronizationAutoNegotiation::onLinkRateChangeTimer.*$/

syn match xAutonegotiation_states contained /Rp3.*Synchronization.*$/ contains=xAutonegotiation_startClock,xAutonegotiation_startSec,xAutonegotiation_stop

syn match  xChannelsState  contained /OFF/
syn match  xChannelsState  contained /FRAME_TX/
syn match  xChannelsState  contained /IDLE/

syn match  xChannelInState contained /Channel RP3\(-01\)\? \d (Gaia\d) set TX to .*/ contains=xChannelsState,xPortName,xChipName1,xChipName2,xChipName3
syn match  xChannelInState contained /Channel RP3\(-01\)\? \d (Gaia\d) in .* state.*/ contains=xChannelsState,xPortName,xChipName1,xChipName2,xChipName3

hi def link xAutonegotiation_states xRouter_VDInf
hi def link xAutonegotiation_startClock xChannelsState 
hi def link xAutonegotiation_startSec xSFP_connected
hi def link xAutonegotiation_stop xSrcClock_set
hi def link xFCB_sync Cursor
hi def link xClockSource Cursor
hi xChipName1 guifg=blue guibg=green
hi xChipName2 guifg=blue guibg=MediumSeaGreen
hi xChipName3 guifg=blue guibg=LimeGreen

