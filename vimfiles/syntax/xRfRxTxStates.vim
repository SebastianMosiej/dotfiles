" REL2
syn match  xChannelsState  contained /\<IDLE\>/
syn match  xChannelsState  contained /\<UNSYNC\>/
syn match  xChannelsState  contained /\<WAIT_FOR_K28\.\?7_IDLES\>/
syn match  xChannelsState  contained /\<WAIT_FOR_K28\.\?5_IDLES\>/
syn match  xChannelsState  contained /\<WAIT_FOR_FRAME_SYNC_T\>/
syn match  xChannelsState  contained /\<WAIT_FOR_ACK\>/
syn match  xChannelsState  contained /\<wait_for_ack\>/
syn match  xChannelsState  contained /\<FRAME_SYNC\>/
syn match  xChannelsState  contained /\<WAIT_FOR_SEED\>/
syn match  xChannelsState  contained /\<off\>/
syn match  xChannelsState  contained /\<idle\(_req\)*\>/
syn match  xChannelsState  contained /\<Idle\>/
syn match  xChannelsState  contained /\<frame\>/
syn match  xChannelsState  contained /\<Frame\>/
syn match  xChannelsState  contained /\<SYSTEM_TIMING\>/
" 
syn match  xChannelsState  contained /\<ETxChnlSyncStatus_Idle\>/
syn match  xChannelsState  contained /\<ETxChnlSyncStatus_Idle_ACK\>/
syn match  xChannelsState  contained /\<ETxChnlSyncStatus_Idle_REQ\>/
syn match  xChannelsState  contained /\<ETxChnlSyncStatus_Frame\>/
syn match  xChannelsState  contained /\<ETxChnlSyncStatus_Off\>/
syn match  xChannelsState  contained /unknown \<.*\>/

syn match  xPortName contained /RP3-01 \d/
syn match  xChannelInState contained /Channel RP3\(-01\)\? \d TX set to \<.*\>/ contains=xChannelsState,xPortName
syn match  xChannelInState contained /Channel RP3\(-01\)\? \d in \<.*\> state/ contains=xChannelsState,xPortName
syn match  xChannelInState contained /Channel RP3-01 \d is in \<.*\>/ contains=xChannelsState,xPortName
syn match  xChannelInState contained /channel RP3-01 \d TxState set to \<.*\>/ contains=xChannelsState,xPortName
syn match  xChannelInState contained /tunePi id=\d\{1,2\} TxState set to \<.*\>/ contains=xChannelsState,xPortName
