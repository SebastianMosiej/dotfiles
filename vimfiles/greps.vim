
command! GrepRouter :%!grep -a -E 'Router_VD|RFMan|ModuleReadyInd|(resetProcedure started)|
      \(ERR/CCS/AaError)|SerialNo is\s|HW environment|StartupComponent, HWID:|[Aa]uthor:|SoftResetManager|
      \sendRestartModule|(Resending message)|(Flushing .* messages)|(Message routed to nowhere)|Rp3Ports::hwReset|
      \McuReset:\s*Type: .* Reset Cause: .* Reset State:'
command! GrepPrimary :%!grep -a -E 'Channel RP3-01 [[:digit:]] (\(Gaia[[:digit:]]\) )*(in|RX|(set TX)|(TX set))|
      \ModuleReady|[Rr]esending|GaiaToGaiaFcbSync procedure|
      \Header :|SFP RX LOS|rx LOS|SFP_LOS|monitorPllInterrupts|ClockCleaner|Set position in chain|
      \resetProcedure started|sendRestartModule|Rp3Ports::hwReset|triggerFilterSwUpdate$|
      \setting clock source to link|WRN/LTX/Router_VD|ERR/LTX|
      \(Rp3Ports::softReset SoftResetManager is active - sending notification)|(numOfGaias=[[:digit:]])|SoftResetManager|
      \McuReset:\s*Type: .* Reset Cause: .* Reset State:|
      \Eeprom: Serial number\s*:|HW environment|StartupComponent|HWID:'
command! GrepSyslog :%!grep -a -i -E '\bFRM_REL[0-9]|(OAM/BBC)|(HWA/SUM)'
command! GrepIdData :%!grep -a -i -E '(\bHW environment\b)|(Active build)|(EepromHelper::serialNumber)|(StartupComponent, HWID)'
command! GrepScheduling :%!grep -a -E '(Adding bus node)|((Adding|Deleting) carrier)|(\s{3,7}\bname\b)|( \bdirection\b=)|(   \bantenna\b=)|(   \blink\b=)|(   \brouting\b)|
      \(   \bpipe\b)|(Adding dual bitmap)|Deleting bus node|
      \(addBusNode,)|(BaseBand: deleteBusNode)|(getRoutingInformation, address)|(Message routed to nowhere)|
      \(operation: upodate_parm.*active)|(settings routing)|SetRouting|(Modifying state of carrier.*active=)|
      \HandlePowerInd|
      \removeRoutedAddress erase routing of address
      \(Mismatched time stamp)|(Summing underflow)|(Summing overflow)'
command! GrepDRouting :%!grep -aE 'SetRouting'
command! GrepHwapi :%!grep -a -E '((Link|Channel) RP3-01 . ((TX set)|((RX )*in)))|((Sending|Received) control message (from|to))|
      \(INF.*\[OptSynchronizer\]\[BBMOD_L-.\|CONNECTOR_L-.\]\[linkId .\] [TR]X is)|
      \(Opt Link . TX changed to .* state)'
command! GrepSyslog :%!grep -a -E '(Link RP3-01 . ((TX set)|(RX in)))|
      \((Sending|Received) control message (from|to))|
      \(INF.*\[OptSynchronizer\]\[[SB]B*MOD_L-.\|CONNECTOR_L-.\]\[linkId .\] [TR]X is)|
      \(INF.*\[RP3ControlMessageBroker\])|
      \((INF.*Discovery.* , SerialNumber: .{3,20}), Link)|
      \((Dispatcher|R.Sender)\[OIC.\]: Rp3CtrlMsg)
      \(R.ASICService.*(TR .*)* [Pp]ort .*[TR]xState is)|((R.Sender|Dispatcher).*Rp3CtrlMsg)'

command! GrepWcdma :%!grep -aE '(Bulk updating MO.*RMOD.*serNum)|(Node with serialNumber)|(COptIf: Nodel Label\[.*\] for OptIF\[0x.*\])'
command! GrepWmpCarriers :%!grep -aEi '(Adding bus node)|(, active=true)|(antenna=antenna)|(direction=.*, address)
      \|(addCarrier|(setting routing))|(Router_VD)|(Adding carrier)
      \|(DL msg lost)'
command! GrepFaults :%!egrep -a '(newAlarm Id)|\bE?[Ff]aultI[dD]|updateAlarmCounter'
