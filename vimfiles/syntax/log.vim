:syn match logRouter    "Router_VD"
:syn match logRP3Ports  "UOM_RFMan"

:syn match logRp3       "RP3-01"
:syn match logRp3       "MED_VirtConn, ModuleReadyInd sent to "
:syn match logRp3       "LinkSpeedManager"

:syn match logSfpRxLos  "SFP RX LOS"
:syn match logSfpRxLos  "SFP_LOS"
:syn match logSfpRxLos  "UDPCP_TX: Could not send all data at the time"
:syn match logSfpRxLos  "VD::Interrupts::Notification"

:syn match logPll "PLL_LOCK is LOCKED" 
:syn match logPll "PLL_LOCK is UNSYNC"

:syn match logState "in UNSYNC state"
:syn match logState "in WAIT_FOR_K28.7_IDLE state"
:syn match logState "in WAIT_FOR_K287_IDLES state"
:syn match logState "in WAIT_FOR_FRAME_SYNC_T state"
:syn match logState "in FRAME_SYNC state"
:syn match logState "in WAIT_FOR_ACK"
:syn match logState "in SYSTEM_TIMING state"

:syn match logStateTx "ETxChnlSyncStatus_Off"
:syn match logStateTx "ETxChnlSyncStatus_Idle"
:syn match logStateTx "ETxChnlSyncStatus_Frame"
:syn match logStateTx "set TX to OFF"
:syn match logStateTx "set TX to IDLE"
:syn match logStateTx "set TX to FRAME_TX"
:syn match logStateTx "GaiaToGaiaFcbSync"

:syn match logHeader ": Header :"
:syn match logHeader "(NodeLabel)"
:syn match logHeader "(NodeReport)"
:syn match logHeader "(Rp3-01PortStatInd)"
:syn match logHeader "(OpticalLinkStatus)"
:syn match logHeader "(NodeType)"
:syn match logHeader "(FwdDirec4DistRP3Router)"
:syn match logHeader "(LinkMNodeLabel)"
:syn match logHeader "(SetDateReq)"
:syn match logHeader "(ForwardingDelay)"
:syn match logHeader "(MacAddr)"
:syn match logHeader "(IPAddr_Netmask)"
:syn match logHeader "(FilterMacAddr)"
:syn match logHeader "(FilterIPAddrNMask)"
:syn match logHeader "(SM_IPAddr)"
:syn match logHeader "(EthernetSchedulingLineRate)"
:syn match logHeader "(EthPorts)"

:syn match logHeaderSpecial "(PortStatus)"
:syn match logHeaderSpecial "(Rp3-01PortCtrl)"

:syn match logGaia "(Gaia0)"
:syn match logGaia "(Gaia1)"
:syn match logGaia "(Gaia2)"

:syn match logInd "(ParamInd)"
:syn match logInd "Rp301StatusNotification published"

:syn match LTE1439 "WeightedPortSelection"
:syn match LTE1439 "LinkBreakHandler"

hi def logRouter 	guibg=yellow guifg=black
hi def logRP3Ports guibg=black guifg=yellow
hi def logSfpRxLos 	guibg=red guifg=white
hi def logState 	guibg=cyan guifg=black
hi def logStateTx 	guibg=grey guifg=black
hi def logRp3 		guibg=blue guifg=white
hi def logPll 		guibg=green guifg=black
hi def logHeader 	guibg=orange guifg=black
hi def logHeaderSpecial guibg=red guifg=white
hi def logGaia 		guibg=green guifg=red
hi def logInd 		guibg=black guifg=yellow
hi def LTE1439      guibg=red guifg=white

:syn match logTrap "RFCtrl_VD, MERA"
hi def logTrap guibg=#000F88 guifg=white
