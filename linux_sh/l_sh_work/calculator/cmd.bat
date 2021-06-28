@echo off
SET PATH=C:\WSL-Win-7\Cmake-Make\make-3.81-bin\bin\;%PATH%
SET PATH=C:\WSL-Win-7\Cmake-Make\cmake-3.12.1-win32-x86\bin\;%PATH%
SET PATH=C:\Qt\Qt5.7.0\5.7\mingw53_32\bin\;C:\Qt\Qt5.7.0\Tools\mingw530_32\bin\;%PATH%
cmd.exe /s /k pushd "%V"
