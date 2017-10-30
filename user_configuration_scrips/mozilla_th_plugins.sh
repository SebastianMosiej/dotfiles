#!/bin/bash -vx

. mozilla_tools.sh

tb_addons=(
  # MinimizeToTray revived
  #https://addons.mozilla.org/thunderbird/downloads/latest/12581/platform:2/addon-12581-latest.xpi
  # Awesome Auto Archive
  https://addons.mozilla.org/thunderbird/downloads/latest/478179/addon-478179-latest.xpi
  # Thunderbird Message Filter Import/Export Enhanced
  https://addons.mozilla.org/thunderbird/downloads/file/189850/thunderbird_message_filter_importexport_enhanced-1.0.3-tb.xpi
  # SmartTemplate4
  https://addons.mozilla.org/thunderbird/downloads/file/428152/smarttemplate4-1.2.1-sm+tb.xpi
  # Tag Toolbar
  https://addons.mozilla.org/thunderbird/downloads/latest/4970/addon-4970-latest.xpi
  # Menu Wizard
  https://addons.mozilla.org/thunderbird/downloads/latest/508352/addon-508352-latest.xpi
  # quickFilters
  https://addons.mozilla.org/thunderbird/downloads/latest/372870/addon-372870-latest.xpi
  # GMailUI
  https://addons.mozilla.org/thunderbird/downloads/latest/1339/addon-1339-latest.xpi
  # Color folders
  https://addons.mozilla.org/thunderbird/downloads/latest/326741/addon-326741-latest.xpi
  # Open Folder Move
  https://addons.mozilla.org/thunderbird/downloads/latest/12018/addon-12018-latest.xpi
  # FiltaQuilla
  https://addons.mozilla.org/thunderbird/downloads/latest/10052/addon-10052-latest.xpi
)

[[ -d $HOME"/.icedove" ]] || { echo "Install Icedove first, then start it at least once"; exit 2; }

get_profile_dir 'icedove'
TB_EXT_DIR=$result'/extensions'
if [ `pgrep icedove | wc -l` -ne 0 ]; then
  echo "Icedove is active - shuting down"
  pkill icedove
fi
echo "Icedove addons installation STARTED"
install_addons $TB_EXT_DIR tb_addons[@]
echo "Icedove addons installation FINISHED"
exit
touch $INSTALLED_FILE

