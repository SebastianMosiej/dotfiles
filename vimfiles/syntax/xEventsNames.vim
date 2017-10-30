if version < 600
  set isk=@,48-57,-,_
else
  setlocal isk=@,48-57,-,_
endif

syn keyword xEventsNames contained API_GET_DAC_VALUE_REQ_MSG API_GET_DAC_VALUE_RESP_MSG evAPI_GET_DAC_VALUE_REQ_MSG evAPI_GET_DAC_VALUE_RESP_MSG
syn keyword xEventsNames contained API_SET_DAC_VALUE_REQ_MSG API_SET_DAC_VALUE_RESP_MSG evAPI_SET_DAC_VALUE_REQ_MSG evAPI_SET_DAC_VALUE_RESP_MSG
syn keyword xEventsNames contained API2_GET_DAC_VALUE_REQ_MSG API2_GET_DAC_VALUE_RESP_MSG evAPI2_GET_DAC_VALUE_REQ_MSG evAPI2_GET_DAC_VALUE_RESP_MSG
syn keyword xEventsNames contained API2_SET_DAC_VALUE_REQ_MSG API2_SET_DAC_VALUE_RESP_MSG evAPI2_SET_DAC_VALUE_REQ_MSG evAPI2_SET_DAC_VALUE_RESP_MSG
syn keyword xEventsNames contained API_GET_OCXO_CAL_REQ_MSG API_GET_OCXO_CAL_RESP_MSG evAPI_GET_OCXO_CAL_REQ_MSG evAPI_GET_OCXO_CAL_RESP_MSG
syn keyword xEventsNames contained API_OVEN_READY_REQ_MSG API_OVEN_READY_RESP_MSG evAPI_OVEN_READY_REQ_MSG evAPI_OVEN_READY_RESP_MSG 
syn keyword xEventsNames contained API_REFCLK_READY_REQ_MSG API_REFCLK_READY_RESP_MSG evAPI_REFCLK_READY_REQ_MSG evAPI_REFCLK_READY_RESP_MSG 
syn keyword xEventsNames contained API_REFCLK_READY_IND_MSG API_OVEN_READY_IND_MSG API_REFCLK_ACTIVITY_IND_MSG
syn keyword xEventsNames contained API_SET_ACTIVE_REFCLK_SOURCE_REQ_MSG API_SET_ACTIVE_REFCLK_SOURCE_RESP_MSG evAPI_SET_ACTIVE_REFCLK_SOURCE_REQ_MSG evAPI_SET_ACTIVE_REFCLK_SOURCE_RESP_MSG
syn keyword xEventsNames contained API_SET_PHASE_DIFF_MEAS_REQ_MSG API_SET_PHASE_DIFF_MEAS_RESP_MSG evAPI_SET_PHASE_DIFF_MEAS_REQ_MSG evAPI_SET_PHASE_DIFF_MEAS_RESP_MSG
syn keyword xEventsNames contained API_PHASE_DIFF_MEAS_IND_MSG API_PHASE_DIFF_MEAS_IND_MSG_WITH_BCN evAPI_PHASE_DIFF_MEAS_IND_MSG evAPI_PHASE_DIFF_MEAS_IND_MSG_WITH_BCN 
