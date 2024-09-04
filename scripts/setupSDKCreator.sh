#!/bin/bash

function setupSDKCreator()
{
  #after SDK Online installer
  local SDKTOOL_PATH=${HOME}/Qt/Tools/sdktool/libexec/qtcreator/sdktool
  if [ ! -e $SDKTOOL_PATH ]; then
    SDKTOOL_PATH=${HOME}/Qt/Tools/QtCreator/share/qtcreator/
    if [ ! -e $SDKTOOL_PATH ]; then
      echo "Lack of sdktool. Exiting"
      exit 1
    fi
  fi

  local QT_VER=6.5.3
  local KIT_NAME=byos.${QT_VER}.apalis-imx6
  local SDK_PATH=/opt/veld/2.0.0/sysroots
  local QT_HOST_QMAKE=$SDK_PATH/x86_64-pokysdk-linux/usr/bin/qmake
  
  #remove old settings
  $SDKTOOL_PATH rmKit --id $KIT_NAME.kit
  $SDKTOOL_PATH rmQt --id $KIT_NAME.qt
  $SDKTOOL_PATH rmTC --id ProjectExplorer.ToolChain.Gcc:$KIT_NAME.gcc
  $SDKTOOL_PATH rmTC --id ProjectExplorer.ToolChain.Gcc:$KIT_NAME.g++
  $SDKTOOL_PATH rmDebugger --id $KIT_NAME.gdb
  $SDKTOOL_PATH rmCMake --id $KIT_NAME.cmake
  #add new one
  $SDKTOOL_PATH addAbiFlavor --flavor poky --oses linux
  $SDKTOOL_PATH addTC --id ProjectExplorer.ToolChain.Gcc:$KIT_NAME.gcc \
  --name 'CoSy GCC' \
  --path $SDK_PATH/x86_64-pokysdk-linux/usr/bin/aarch64-veld-linux/aarch64-veld-linux-gcc --abi arm-linux-generic-elf-64bit \
  --language 1
  $SDKTOOL_PATH addTC \
  --id ProjectExplorer.ToolChain.Gcc:$KIT_NAME.g++ \
  --name 'CoSy G++' \
  --path $SDK_PATH/x86_64-pokysdk-linux/usr/bin/aarch64-veld-linux/aarch64-veld-linux-g++ --abi arm-linux-generic-elf-64bit \
  --language 2
  $SDKTOOL_PATH addDebugger \
  --id $KIT_NAME.gdb \
  --name 'Cosy GDB' \
  --engine 1 \
  --binary $SDK_PATH/x86_64-pokysdk-linux/usr/bin/aarch64-veld-linux/aarch64-veld-linux-gdb --abis arm-linux-generic-elf-64bit

  $SDKTOOL_PATH addQt \
  --id $KIT_NAME.qt \
  --name 'CoSy Qt Qt 6.5.3' \
  --type "RemoteLinux.EmbeddedLinuxQt" \
  --qmake $SDK_PATH/x86_64-pokysdk-linux/usr/bin/qmake
  $SDKTOOL_PATH addCMake \
  --id $KIT_NAME.cmake \
  --name 'CoSy CMake v3.27' \
  --path $SDK_PATH/x86_64-pokysdk-linux/usr/bin/cmake 

  ENV_VALUES=()

  while IFS= read -r line; do
      if [[ "$line" =~ "export "(.*) ]]; then
          ENV_VALUES+=( --env "${BASH_REMATCH[1]//\"/}" )
      fi
  done < $SDK_PATH/../environment-setup-cortexa53-crypto-veld-linux

  $SDKTOOL_PATH addKit \
  --id $KIT_NAME.kit \
  --name 'CoSy Qt 6.5.3 Target' \
  --qt $KIT_NAME.qt \
  --debuggerid $KIT_NAME.gdb \
  --Ctoolchain ProjectExplorer.ToolChain.Gcc:$KIT_NAME.gcc \
  --Cxxtoolchain ProjectExplorer.ToolChain.Gcc:$KIT_NAME.g++ \
  --cmake $KIT_NAME.cmake \
  --devicetype GenericLinuxOsType \
  --icon :/boot2qt/images/B2Qt_QtC_icon.png \
  --sysroot $SDK_PATH/cortexa53-crypto-veld-linux \
  --cmake-config CMAKE_CXX_COMPILER:FILEPATH=$SDK_PATH/x86_64-pokysdk-linux/usr/bin/aarch64-veld-linux/aarch64-veld-linux-g++ \
  --cmake-config CMAKE_C_COMPILER:FILEPATH=$SDK_PATH/x86_64-pokysdk-linux/usr/bin/aarch64-veld-linux/aarch64-veld-linux-gcc \
  --cmake-config TARGET_BUILD:BOOL=TRUE \
  --cmake-config TARGET_VNC_BUILD:BOOL=TRUE \
  --cmake-config TARGET_DEBUG:BOOL=TRUE \
  --cmake-config APP_TESTBED_MOCKS_ENABLED:BOOL=FALSE \
  --cmake-config RUN_ON_DESKTOP:BOOL=FALSE \
  --cmake-config CMAKE_INSTALL_PREFIX:PATH=/mnt/appfs/nwot-appfs1/opt/qt \
  --cmake-config QT_QMAKE_EXECUTABLE:FILEPATH=$SDK_PATH/x86_64-pokysdk-linux/usr/bin/qmake \
  --cmake-config PYTHON_EXECUTABLE:UNINITIALIZED=/usr/bin/python3 \
  --env "QT_HOST_PATH=$SDK_PATH/x86_64-pokysdk-linux/usr/" \
  "${ENV_VALUES[@]}"
}

setupSDKCreator

