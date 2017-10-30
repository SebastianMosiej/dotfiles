syn match  xFaultCleared  contained /State: \zscleared\ze,/
syn match  xFaultCleared  contained /cleared alarm.*/
syn match  xFaultActive   contained /State: \zsactive\ze,/
syn match  xFaultActive   contained /active alarm.*/
syn match  xFaultState    contained /State: .\{-5,}./ contains=xFaultActive,xFaultCleared
syn match  xFaultCritical contained /Severity: \zscritical\ze,/
syn match  xFaultName     contained /EFaultId_.\{-5,},/
syn match  xFaultId       contained /Id: \zs\d\{1,4}\ze/
syn match  xFault         contained /\(void\)* Uoam.*handleFaultIndication.*received Fault .*, Id: \d\{1,4}, Source: .*, Severity: .*, State: .*, DeviceType: .*, DeviceId: \d\{1,3}, faultCause = .*/ contains=xFaultId,xFaultName,xFaultCritical,xFaultState
syn match  xFault         contained /::AlarmCounter updateAlarmCounter(), .*/ contains=xFaultCleared,xFaultActive

hi def link xFaultId DiffAdd
hi def link xFaultName LineNr
hi def link xFaultCritical ErrorMsg
hi def link xFaultState xFault
hi def link xFaultActive WarningMsg
hi def link xFaultCleared Question
