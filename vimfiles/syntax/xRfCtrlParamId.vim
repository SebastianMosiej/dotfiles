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

syn match xRfCtrlParamId contained "NodeReport"
syn match xRfCtrlParamId contained "NodeLabel"
syn match xRfCtrlParamId contained "LinkMNodeLabel"
syn match xRfCtrlParamId contained "Rp3-01PortCtrl"
syn match xRfCtrlParamId contained "Rp3-01PortStatInd"
syn match xRfCtrlParamId contained "NodeType"
syn match xRfCtrlParamId contained "MasterRoleScoring"
syn match xRfCtrlParamId contained "SpeedChangeReq"
syn match xRfCtrlParamId contained "PortSpeedCapab"
syn match xRfCtrlParamId contained "PortSpeedChange"
syn match xRfCtrlParamId contained "PiOffsets"
syn match xRfCtrlParamId contained "BufferInitial"
syn match xRfCtrlParamId contained "PiMeasurement"
syn match xRfCtrlParamId contained "TxOffsets"
syn match xRfCtrlParamId contained "DeltaCorrection"
syn match xRfCtrlParamId contained "ForwardingDelay"
syn match xRfCtrlParamId contained "CurrentFifoFillLevel"
syn match xRfCtrlParamId contained "FwdDirec4DistRP3Router"
syn match xRfCtrlParamId contained "LineRateNegotiationTimer"
syn match xRfCtrlParamId contained "IPAddr_NetMask"
syn match xRfCtrlParamId contained "MacAddr"
syn match xRfCtrlParamId contained "FilterIPAddrNMask"
syn match xRfCtrlParamId contained "FilterMacAddr"
syn match xRfCtrlParamId contained "SM_IPAddr"
syn match xRfCtrlParamId contained "EthPorts"
syn match xRfCtrlParamId contained "EthScheduling"
syn match xRfCtrlParamId contained "OAMScheduling"
syn match xRfCtrlParamId contained "Rp3ConnState"
syn match xRfCtrlParamId contained "GPSPPsPhaseOffsV"
syn match xRfCtrlParamId contained "SysmodNodeId"
syn match xRfCtrlParamId contained "MSysmodNodeId"
syn match xRfCtrlParamId contained "PortStatus"
syn match xRfCtrlParamId contained "OpticalLinkStatus"
syn match xRfCtrlParamId contained "OAMSchedulingLineRate"
syn match xRfCtrlParamId contained "EthernetSchedulingLineRate"
syn match xRfCtrlParamId contained "LCVMonitorCtrl"
syn match xRfCtrlParamId contained "LCVMonitorInd"
syn match xRfCtrlParamId contained "LinkSupervisionTimers"
syn match xRfCtrlParamId contained "RecoveryInfo"
syn match xRfCtrlParamId contained "RFtransmit"
