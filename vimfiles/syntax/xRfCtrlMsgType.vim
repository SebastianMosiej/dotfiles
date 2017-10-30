if version < 600
  set isk=@,48-57,-,_
else
  setlocal isk=@,48-57,-,_
endif

syn match xRfCtrlMsgType contained "RMID Ind"
syn match xRfCtrlMsgType contained "RMID Resp"
syn match xRfCtrlMsgType contained "RMStatInd"
syn match xRfCtrlMsgType contained "RMStatIndACK"
syn match xRfCtrlMsgType contained "SetDelayVal"
syn match xRfCtrlMsgType contained "SetDelayValRes"
syn match xRfCtrlMsgType contained "InitIPStack"
syn match xRfCtrlMsgType contained "InitIPStackRes"
syn match xRfCtrlMsgTypeGet contained "GetParameter"
syn match xRfCtrlMsgTypeSet contained "SetParameter"
syn match xRfCtrlMsgTypeInd contained "ParamInd"
syn match xRfCtrlMsgType contained "ParamRes"
syn match xRfCtrlMsgType contained "ParamACK"
syn match xRfCtrlMsgTypeNACK contained "ParamNACK"
syn match xRfCtrlMsgTypeReset contained "ResetNode"
syn match xRfCtrlMsgTypeReset contained "ResetACK"
syn match xRfCtrlMsgType contained "Rp3V3Nack"
syn match xRfCtrlMsgType contained "SWrapRp3V2Msg"
syn match xRfCtrlMsgType contained "SWrapRp3V2Ack"
syn match xRfCtrlMsgType contained "RWrapRp3V2Ind"
syn match xRfCtrlMsgType contained "RWrapRp3V2Ack"
syn match xRfCtrlMsgType contained "SetDateReq"
syn match xRfCtrlMsgType contained "SetDateReqAck"
syn match xRfCtrlMsgType contained "DiagnosticDataRead"
syn match xRfCtrlMsgType contained "DiagnosticDataResponse"
