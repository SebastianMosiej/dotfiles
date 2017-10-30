syn match xRfCarrierNotActive contained /\zsfalse\ze/
syn match xRfCarrierActive contained /\zstrue\ze/
syn match xRfCarrierActivity contained /active=.*/ contains=xRfCarrierActive,xRfCarrierNotActive

syn match xRfCarrierName contained /name='\zs.\{-1,20\}\ze'/

syn match xRfSchedulingValues contained /\<\d\{-1,5\}\>/
syn match xRfBusNodeDeleting contained /Deleting bus node/
syn match xRfBusNodeDeleting contained /deleteBusNode/
syn match xRfBusNodeDeleting contained /Deleting carrier/
syn match xRfBusNodeAdding contained /Adding bus node/
syn match xRfBusNodeAdding contained /addBusNode/
syn match xRfCarrierDirection contained /downlink\|uplink/
syn match xRfCarrierAntenna contained /antenna\d[ab]/

"-----

syn match xRfScheduling  contained  /BaseBand: \(deleteBusNode\|addBusNode\), address=.*. downlinkPorts=.*, uplinkPorts=.*/ contains=xRfBusNodeDeleting,xRfBusNodeAdding,xRfSchedulingValues
syn match xRfScheduling  contained  /Radio\(::\|,\)\s\{3,5\}antenna=.*/ contains=xRfCarrierAntenna
syn match xRfScheduling  contained  /Radio\(::\|,\)\s\{3,5\}direction=.*/ contains=xRfCarrierDirection
syn match xRfScheduling  contained  /Radio\(::\|,\)\s\{3,5\}name=.*/ contains=xRfCarrierName
syn match xRfScheduling  contained  /Deleting carrier, name='.*'/ contains=xRfCarrierName,xRfBusNodeDeleting,xRfBusNodeDeleting
syn match xRfScheduling  contained  /Deleting bus node, name='.*'/ contains=xRfCarrierName,xRfSchedulingValues,xRfBusNodeDeleting
syn match xRfScheduling  contained  /Adding bus node, name='.*', address=.*, index=.*, modulo=.*, routing=.*, bitmapRule='.*', channel=.*, source=.*/ contains=xRfCarrierName,xRfSchedulingValues,xRfBusNodeAdding
syn match xRfScheduling  contained  /Modifying state of carrier, name='.*', active=.*/ contains=xRfCarrierActivity,xRfCarrierName

hi def link xRfScheduling xEntryInf
hi def link xRfCarrierActivity xEntryInf
hi def link xRfCarrierActive Question
hi def link xRfCarrierNotActive WarningMsg
hi def link xRfCarrierName  LineNr
hi def link xRfSchedulingValues  LineNr
hi def link xRfCarrierDirection  LineNr
hi def link xRfCarrierAntenna  LineNr
hi def link xRfBusNodeDeleting  WarningMsg
hi def link xRfBusNodeAdding  Question

