if version < 600
  set isk=@,48-57,-,_
else
  setlocal isk=@,48-57,-,_
endif

syn keyword xSubsystemsName contained GEN OAM TCOM UDPPRINTPORT HEAP_TRACE 
syn keyword xSubsystemsName contained RAW_ALARM PRINTFILTER SW_DL INIT ADET 
syn keyword xSubsystemsName contained STARTLOG_TIME STARTLOG_SIZE WDOG TUNE TCOM_MASTER 
syn keyword xSubsystemsName contained FAULT CLIC CELLPOWERMAX TCOM_MASTER_VALUE 
syn keyword xSubsystemsName contained OM_MASTER_VALUE WSP_SELFTEST PROD_TEST 
syn keyword xSubsystemsName contained PROD_TEST_MONI RECO TPGC MEM_LOAD_TEST ISTI 
syn keyword xSubsystemsName contained FORCED_CABINETTYPE MHA_CONTROL WSMA ASSERT 
syn keyword xSubsystemsName contained CONN POLL HEAPLEN HEAPSIZE CLOCKS PERF_MONIT 
syn keyword xSubsystemsName contained NAT FILT_NONEAC TCOM_CONFIGURATION_DELAY PRINT_PRI 
syn keyword xSubsystemsName contained HEAPWALK ANTENNALOSS DUAL_CARRIER OMIT_UPWARMING 
syn keyword xSubsystemsName contained SWB_MON DISABLE_CONF_CHANGE_TO_TCOM FIXED_FANS DB_CHANGE_LOG 
syn keyword xSubsystemsName contained TUNE_AVG FLDP RHAPSODY_FW STUP_RESET FTP_TESTER FTP_ADDR 
syn keyword xSubsystemsName contained AXU_RECONFIG_TIME CONF DISABLE_WTR_AL DISABLE_DSP_AL DISABLE_ATM_AL SNTP 
syn keyword xSubsystemsName contained AXU_POLLING_DISABLED STUP CR104 CR104 HGW TASSUMONMODE 
syn keyword xSubsystemsName contained TASSUMON1 TASSUMON2 TASSUMON3 TASSUMON4 ATMUX TR BR 
syn keyword xSubsystemsName contained SW_DL AIF INIT GENIO I2C INET CD CTRL AUTO_DET 
syn keyword xSubsystemsName contained RP_RAM PERF_M ID_S 
syn keyword xSubsystemsName contained SWB_DBLK_BURSTLEN SWB_DBLK_BURSTDELAY PRINT_HIGH_WATERMARK 
syn keyword xSubsystemsName contained PRINT_LOW_WATERMARK OAM_MSG_TO_TASSU TCOM_MSG_TO_TASSU 
syn keyword xSubsystemsName contained UNIT_TESTS_WITHOUT_WPAS CODE_TRACKING HEAP LOG_HEAP_RESET 
syn keyword xSubsystemsName contained BIST SELF_TEST COMMON TCP_ECHO_SERVER UDP_ECHO_SERVER 
syn keyword xSubsystemsName contained IGNORE_CRCS SWBPOLL FEAT_DBG_SWBUS_CRC DISABLE_WSMCFG 
syn keyword xSubsystemsName contained HEAP_POLL HEAP_FREE_LIMIT HEAP_BLOCK_LIMIT TURBO_RESET EXCESS IUB 
syn keyword xSubsystemsName contained PCI B RRI RLM SFN BCI PWR USI 
syn keyword xSubsystemsName contained FPA P XA E CC NC HWINFO START-UP_TIMER 
syn keyword xSubsystemsName contained RTM_DISABLE RTM_RETRY RTM_TMO RTM WSPC_TYPE WSMB_INIT_DUMP WSPC_CHECK 
syn keyword xSubsystemsName contained SFN_POLL ATM_FP SWMG WIDM WSPC_SFNPOLL_WD_DISABLE DSP_LOAD_DISABLE INTELLIGENT_SHUTDOWN 
syn keyword xSubsystemsName contained FEAT_DBG_LCS HWINQ BLOC FORE_SM FEAT_DBG_POST_FAILURE BOARD TEST_DEDICATED RUNTIME_LOG TECHREP 
syn keyword xSubsystemsName contained HWCTRL CFT GPS IPADDR LCS_DELAY1 LCS_DELAY2 LCS_DELAY3 
syn keyword xSubsystemsName contained LCS_DELAY4 LCS_DELAY5 LCS_DELAY6 LCS_DELAY7 LCS_DELAY8 WSMB_LED_CTRL STACK_INCREASE 
syn keyword xSubsystemsName contained COPY_PM_LOG_TO_WAM FLASH_STAT_MON HO_RESULT_DENIED TCP_RETRY CDMA_LOOP_KNIFE WSMA_RX_DELAY 
syn keyword xSubsystemsName contained WSMB_RT_DEL1_WTRA WSMB_RT_DEL1_WTRB WSMB_RT_DEL2_WTRA WSMB_RT_DEL2_WTRB 
syn keyword xSubsystemsName contained WSMB_ST_DEL2_WTRA_TRIPLE WSMB_ST_DEL2_WTRB_TRIPLE WSMB_ST_DEL2_WTRA_OTHER WSMB_ST_DEL2_WTRB_OTHER 
syn keyword xSubsystemsName contained WSMB_RR_DEL1_WTRA WSMB_RR_DEL1_WTRB WSMB_RR_DEL2_WTRA WSMB_RR_DEL2_WTRB WSMB_SR_DEL_WTRA_TRIPLE WSMB_SR_DEL_WTRB_TRIPLE 
syn keyword xSubsystemsName contained WSMB_SR_DEL_WTRA_OTHER WSMB_SR_DEL_WTRB_OTHER CPU_LOAD_MON 
syn keyword xSubsystemsName contained ETH_DESTROY ETH_DESTROY_LOCAL_ADDR ETH_DESTROY_REMOTE_ADDR ETH_DESTROY_TX_CNT ETH_DESTROY_RX_CNT LCS_RTT_NFLOSS LCS_RTT_NDELAY 
syn keyword xSubsystemsName contained WSMB_RT_DEL1_WTRD WSMB_RT_DEL2_WTRD WSMB_ST_DEL2_WTRD_TRIPLE WSMB_ST_DEL2_WTRD_OTHER 
syn keyword xSubsystemsName contained WSMB_RR_DEL1_WTRD WSMB_RR_DEL2_WTRD WSMB_SR_DEL_WTRD_TRIPLE WSMB_SR_DEL_WTRD_OTHER 
syn keyword xSubsystemsName contained CT G CH R RM T AC DM CM RAR_RESET_TM RAR_RESET_CNT POOL_OBSERVER 
syn keyword xSubsystemsName contained WSMB_RT_DEL1_WTRA_TRIPLE WSMB_RT_DEL1_WTRB_TRIPLE WSMB_RT_DEL2_WTRA_TRIPLE WSMB_RT_DEL2_WTRB_TRIPLE 
syn keyword xSubsystemsName contained WSMB_RR_DEL1_WTRA_TRIPLE WSMB_RR_DEL1_WTRB_TRIPLE WSMB_RR_DEL2_WTRA_TRIPLE WSMB_RR_DEL2_WTRB_TRIPLE PARA TESTER_INTERFACE BTS_LOG 
syn keyword xSubsystemsName contained WSMA_RX_DELAY_TRIPLE BPF_DISABLE NO_RAMP_DOWN_ON_CELL_DELETE NMAP_GW UDPCP UDPCP_RX UDPCP_TX 
syn keyword xSubsystemsName contained DISABLE_MO_CHANGE AUTOTEST_DEDICATED_STATE ENABLE_DB_STATISTICS ARIO Disable_RadParam_Hwapi Disable_RadParam_Telecom Disable_RadParam_Tup 
syn keyword xSubsystemsName contained Disable_RadParam_DspCodec Disable_RadParam_DspRake Disable_RadParam_DspMachs Disable_RadParam_All_SC AUTH AUTH_DISABLED RPMAG 
syn keyword xSubsystemsName contained HWAPI_UDPCP_Stat_Print ADSER EnableAlarmReporting SWMAG Enable_SoapTrace Enable_AlTrace APW OIC_TASK CASA2_TASK 
syn keyword xSubsystemsName contained HWAPIResetService SDL_STALL_INT SDL_STALL_LENGTH RLM_TRASH_TRESH SIR_TRASH_TRESH CMEAS_PRIO 
syn keyword xSubsystemsName contained DMEAS_PRIO COMMIT_CFN_SFN MTTester NbrOfOldAPWMessages APWTraceFileStoringPlace 
syn keyword xSubsystemsName contained DUAL_BAND_SUPPORT SUM_SERVICE SUM_SERVICE_TEST_MESSAGES DWI TESTIFAPPL PM ENABLE_DWI Tune_FreqHistory UDP_PRINT_ADDRESS BBC FDRules_Distr 
syn keyword xSubsystemsName contained FEAT_DBG_BTSCommissioned FEAT_DBG_NoRFModules FEAT_DBG_NoFilters FEAT_DBG_NumberOfFSP BTSOM_BBC_MANUAL_CONF Enable_DbgPrint_to_BtsLog HEAP_MONITORING 
syn keyword xSubsystemsName contained DspTraceMaxTime DspTraceMinTime DspTraceMaxFileSize TRACE_BUFFER_MAX_SIZE POOL_STATUS_INTERVAL OPT Disable_Licence_Validation Enable_Lic&Opt_Mgmt EnablingFD DSPDump 
syn keyword xSubsystemsName contained PROF_ENABLED MONITORED_PID1 MONITORED_PID2 MONITORED_PID3 MONITORED_PID4 PROF_IP_ADDRESS PROF_PORT TRANS_TASK_PRI RING_BUFFER_SIZE WSMB_Register_Read 
syn keyword xSubsystemsName contained TLH TRACE_BUFFER_EMPTY_INTERVAL TRACE_BUFFER_PACKET_SIZE HWAPI_IF Test_Channel_TxPower Enable_CDMA_loop_param_read_from_dbw FUM FSM_Creator SPMAG 
syn keyword xSubsystemsName contained FEAT_DBG_Test_EthernetTestEnabled FEAT_DBG_Test_Ethernet_poll_waitTimeout FEAT_DBG_Test_EthernetTest_MT_SCT_Enabled FEAT_DBG_Test_EthernetTestAdvancedInfoEnabled ALMAG 
syn keyword xSubsystemsName contained SW_RECOVERY_TIMEOUT DSP_IF HW_CTRL_SERVICE MODULE_TYPE SNTPCheckPeriod LicenceCheckPeriod FeatureCheckPeriod ETH_SERVICE EthRecoReset CDM DBDumpObjCount DBDumpTimer 
syn keyword xSubsystemsName contained CLOCK MIRRORSRC1 MIRRORDST1 MIRRORDIR1 MIRRORSRC2 MIRRORDST2 MIRRORDIR2 TPT CLOCK_TUNING ACNF Test LoopTest LoopTest_Detail EAC DISP LED UHNDSD 
syn keyword xSubsystemsName contained DISABLE_TUP Enable_MasteLoop_print Enable_ExtraMasteLoop_print Enable_MasteLoop_Log_files Enable_MasteLoop_Dual_Branch Disable_MasteLoop_Feature HeapTracePID ClicFixedFanSpeed 
syn keyword xSubsystemsName contained INSPAP_UL_DELAY INSPAP_DL_DELAY ProdTest_TXDigitalGain Disable_ScfFromFlash Disable_Channel_Validation ISTI_Timer_Divider ClicMinuteCounter ClicHourCounter 
syn keyword xSubsystemsName contained FEAT_DBG_TechRep_MT_SCT_Enabled CabinetTest_debug_prints FEAT_DBG_Test_Enable_CabinetTest_Feature FEAT_DBG_Test_Enable_MasteLoopGetAntennaHWInfoFromBBC EnableAllFeatures 
syn keyword xSubsystemsName contained TechRep_FD_Trap_Log_Trigger1 TechRep_FD_Trap_Log_Trigger2 TechRep_FD_Trap_Log_Trigger3 TechRep_FD_Trap_Log_Trigger4 TechRep_FD_Trap_Log_Trigger5 SET_FSM_MODE 
syn keyword xSubsystemsName contained FEAT_DBG_FRresetDelayTimer FEAT_DBG_Test_Enable_TxRxOptimization FEAT_DBG_Test_Enable_FspDspOptimization FEAT_DBG_Conf_LicensePollingTimer FEAT_DBG_Conf_LicenseFeatureDisabled 
syn keyword xSubsystemsName contained Illuminator_Port ForceDspDump DisableFTMReadyCheck DisableFanControl DisableTempTrace ALMAG_VSWR_Threshold_Timer BootCoreSWDL ALSupervisionTimer AntennaLineTestEnabled 
syn keyword xSubsystemsName contained Site_Reset_Allowed GAIN FEAT_DBG_ETH_HCSM_MIRROR_SRC_PORT0 FEAT_DBG_ETH_HCSM_MIRROR_SRC_PORT1 FEAT_DBG_ETH_HCSM_MIRROR_SRC_PORT2 FEAT_DBG_ETH_HCSM_MIRROR_SRC_PORT3 
syn keyword xSubsystemsName contained FEAT_DBG_ETH_HCSM_MIRROR_SRC_PORT4 FEAT_DBG_ETH_HCSM_MIRROR_SRC_PORT5 FEAT_DBG_ETH_HCSM_MIRROR_SRC_PORT6 
syn keyword xSubsystemsName contained FEAT_DBG_ETH_HCSM_MIRROR_SRC_PORT7 FEAT_DBG_ETH_HCSM_MIRROR_SRC_PORT8 FEAT_DBG_ETH_HCSM_MIRROR_SRC_PORT9 FEAT_DBG_ETH_HCSM_MIRROR_INGRESS_DST_PORT FEAT_DBG_ETH_HCSM_MIRROR_EGRESS_DST_PORT 
syn keyword xSubsystemsName contained BTSOMStub BTSOMStub_AmounfOfFaradays BTSOMStub_TupFaradayId FEAT_DBG_Test_Set_EthTestReceivePriority FEAT_DBG_Test_Set_EthTestSendPriority FEAT_DBG_Test_EthernetTestPrint 
syn keyword xSubsystemsName contained FEAT_DBG_BTSOM_Test_Enable_Big_successLimitPromille BBTraceMaxFileSize BB_TRACE NO_WID_CHECK PMFREEZE BTSOM_ALMAG_Device_Detection_Timer TrialPeriodTime 
syn keyword xSubsystemsName contained MasterFDU_1_Start MasterFDU_1_End MasterFDU_2_Start MasterFDU_2_End MasterFDU_3_Start MasterFDU_3_End FeatureStatusInExceptionalSituations RAMLH 
syn keyword xSubsystemsName contained SPMAG_FspDePoweringDisabled FEAT_DBG_BTSOM_TEST_CINR_OFFSET NO_PPS DSPHsupaL2 FEAT_DBG_BTSOMStub_FaradayMemTest GPS_Agent FORCE_FYR_RNW_CONF 
syn keyword xSubsystemsName contained TNR TNR_PRIO RxBERTest12Cells RADPARAMS Mediator TCOM_SCT_param_file FEAT_DBG_HeapStackTrace FEAT_DBG_HeapStackTraceSetCallerAddIndex FEAT_DBG_FasterPollInterval 
syn keyword xSubsystemsName contained PoolAnalyzerDisabling Tune_AgingWeightFactor Tune_TemperatureWeightFactor Tune_FreqResolutionWeightFactor DF FEAT_DBG_BTSOM_Test_Force_Wimax_Digital_Loop HWInq_waitingforNotif PM_TESTS_ShortMeasPeriod 
syn keyword xSubsystemsName contained PM_TESTS_PreserveFiles DisableAntennaConfDataChecksum HWInq_notif_enable BTSOM_Enable_BB_TestRoutes RROM_Adapter Ignore_Muksu_Errors Ignore_Casa_Errors Ignore_RROM_Errors Disable_LTE_Faraday_Polling 
syn keyword xSubsystemsName contained AISG11PollInterval OAM_MasterIPAddress OAM_MasterPort BBOAM_PM_Enabled BBOAM_SWMG_Enabled BBOAM_FM_Enabled BBOAM_TEST_Enabled BBOAM_TECHLOG_Enabled BBOAM_CONF_Enabled BBOAM_NoResetInPolling 
syn keyword xSubsystemsName contained BBOAM_SOAP_TRACE BBOAM_AIF_CONFIGURATION_Disabled LOG_TRACE_POINT_NONE LOG_TRACE_POINT_PARAMETER_DB LOG_TRACE_POINT_OAM_IF LOG_TRACE_POINT_MACPDU LOG_TRACE_POINT_ETHCS LOG_TRACE_POINT_PHYSAP 
syn keyword xSubsystemsName contained LOG_TRACE_POINT_TEST_PROCESS LOG_TRACE_POINT_PLATFORM_IF LOG_TRACE_POINT_RRA LOG_TRACE_POINT_RRA_DL_SCHED LOG_TRACE_POINT_RRA_UL_SCHED 
syn keyword xSubsystemsName contained LOG_TRACE_POINT_RRA_DL_MAP LOG_TRACE_POINT_RRA_UL_MAP LOG_TRACE_POINT_RRA_DL_RESALLOC LOG_TRACE_POINT_RRA_UL_RESALLOC LOG_TRACE_POINT_RRA_LINK_ADAPT 
syn keyword xSubsystemsName contained LOG_TRACE_POINT_RRA_PWR_CONTROL LOG_TRACE_POINT_RRA_MEAS LOG_TRACE_POINT_RRA_RNGFUNC LOG_TRACE_POINT_RRA_UCD_DCD BBOAM_DBDump BBOAM_POSTFail BBOAM_FMUTIL_IPAddress BBOAM_NoAIFResp BBOAM_SkipRansuConf 
syn keyword xSubsystemsName contained LOG_TRACE_POINT_RRA_TXRXVECTORS LOG_TRACE_POINT_USERPLANE LOG_TRACE_POINT_CTRLPLANE LOG_TRACE_POINT_CTRLPLANE_RANGING LOG_TRACE_POINT_CTRLPLANE_MS LOG_TRACE_POINT_CTRLPLANE_SERV LOG_TRACE_POINT_MEAS_MONITOR 
syn keyword xSubsystemsName contained LOG_TRACE_POINT_CPU_MONITOR LOG_TRACE_POINT_MEMORY_MONITOR LOG_TRACE_POINT_TIMING_MONITOR LOG_TRACE_POINT_CTRLPLANE_DS LOG_TRACE_POINT_CTRLPLANE_ENTRY LOG_TRACE_POINT_CTRLPLANE_HO LOG_TRACE_POINT_CTRLPLANE_IDLE_SLEEP 
syn keyword xSubsystemsName contained LOG_TRACE_POINT_CTRLPLANE_AES LOG_TRACE_POINT_CTRLPLANE_SA LOG_TRACE_POINT_ENABLE_DISABLE_OPERATION LOG_TRACE_POINT_RRA_DL_MONITOR LOG_TRACE_POINT_RRA_UL_MONITOR LOG_TRACE_POINT_RRA_DL_RESALLOC_ZONE 
syn keyword xSubsystemsName contained LOG_TRACE_POINT_RRA_DL_RESALLOC_BURST LOG_TRACE_POINT_RRA_UL_RESALLOC_ZONE LOG_TRACE_POINT_RRA_UL_RESALLOC_BURST LOG_TRACE_POINT_RRA_DL_SCHED_RR LOG_TRACE_POINT_RRA_UL_SCHED_RR LOG_TRACE_POINT_RRA_DL_SCHED_DWRR 
syn keyword xSubsystemsName contained LOG_TRACE_POINT_RRA_UL_SCHED_WRR LOG_TRACE_POINT_USERPLANE_DATAPATH LOG_TRACE_POINT_UL_DL_MAP LOG_TRACE_POINT_R6 LOG_TRACE_POINT_R6_NW_ENTRY LOG_TRACE_POINT_R6_NW_EXIT LOG_TRACE_POINT_R6_DATA_PATH LOG_TRACE_POINT_R6_IDLE_MODE 
syn keyword xSubsystemsName contained LOG_TRACE_POINT_R6_PAGING_LU LOG_TRACE_POINT_R6_HO LOG_TRACE_POINT_R6_KEY_CHANGE LOG_TRACE_POINT_CTRLPLANE_SCANNING LOG_TRACE_POINT_MEMORY_POOL LOG_TRACE_POINT_MEMORY_POOL_STATUS LOG_TRACE_POINT_PERFORMANCE_COUNTERS_DB 
syn keyword xSubsystemsName contained LOG_TRACE_POINT_MAC_UTILITIES LOG_TRACE_POINT_USER_PARAMETERS_INPUT LOG_TRACE_POINT_CTRLPLANE_PAGING BBOAM_MAC_TP_CONF DISABLE_FILE_CHKSUM_CALC FEAT_DBG_BTSOM_SPMAG_StartRp3LinkSyncTimeout WaitingForCfgChecking CMU 
syn keyword xSubsystemsName contained FCM_SlaveRP1 MemDumpRamLimit GPW CONF_Validator NumUDPPackets BTSOM_OXF CFM CDM uncommissionedBTS AUTOCONN_DISABLE AUTOCONN_TIMEOUT DisableRamlScf POST_Coverage CLIC_HoldOverSupport FSPSKIP 
syn keyword xSubsystemsName contained FEAT_DBG_BTSOM_Enable_DSP_Configuration_file FEAT_DBG_BTSOM_Enable_SUM_service_Configuration_file FEAT_DBG_BTSOM_Skip_TargetId_Verification MasterNIDSkip IPSecDisabled CAConfHandler FSPCreator ThreadPriority LMP_Feature FEAT_DBG_BTSOM_CFM_AgentTimer 
syn keyword xSubsystemsName contained FEAT_DBG_BTSOM_OMG GPS_FILTERING_PPS_CHANGE FEAT_DBG_BTSOM_EnableVendorHandling FEAT_BTSOM_Keep_Alive_Timer PM_Unconditional_File_Creation FEAT_DBG_BTSOM_AUTOCONN_RESTART_TMO FEAT_DBG_BTSOM_ALMAG_timer_overcurrent_filtering_alarm 
syn keyword xSubsystemsName contained FEATURE_PLUS_50_NAMES
