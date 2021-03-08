#!/bin/bash
_file_cfg="./Boevoy.ini"
_config1=(STestFile10 STestFile8)
_zamena="100.000"
_zamena2="50"
cat $_file_cfg | grep "${_config1[0]}"
cat $_file_cfg | grep "${_config1[1]}"
sed -i "s/\\${_config1[0]}.*/${_config1[0]}=$_zamena/" $_file_cfg
sed -i "s/\\${_config1[1]}.*/${_config1[1]}=$_zamena2/" $_file_cfg
cat $_file_cfg | grep "${_config1[0]}"
cat $_file_cfg | grep "${_config1[1]}"
_zamena="500.000"
_zamena2="100"
sed -i "s/\\${_config1[0]}.*/${_config1[0]}=$_zamena/" $_file_cfg
sed -i "s/\\${_config1[1]}.*/${_config1[1]}=$_zamena2/" $_file_cfg
cat $_file_cfg | grep "${_config1[0]}"
cat $_file_cfg | grep "${_config1[1]}"
_zam=(100 30)
sed -i "s/\\${_config1[0]}.*/${_config1[0]}=${_zam[0]}/" $_file_cfg
sed -i "s/\\${_config1[1]}.*/${_config1[1]}=${_zam[1]}/" $_file_cfg
cat $_file_cfg | grep "${_config1[0]}"
cat $_file_cfg | grep "${_config1[1]}"
exit 0
