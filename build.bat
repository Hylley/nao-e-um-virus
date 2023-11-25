@echo off
chcp 65001

set love_path_64="C:\Program Files\LOVE\"
set love_path_86="C:\Program Files (x86)\LOVE"
set executable=não-é-um-vírus

if not exist tmp mkdir tmp
if not exist build mkdir build
if not exist build\x64 mkdir build\x64
if not exist build\x32 mkdir build\x32

powershell Compress-Archive -Path src\* -DestinationPath tmp\out.zip
cd tmp
ren *.zip *.love
cd ..

copy /b %love_path_64%love.exe+"tmp\out.love" build\x64\%executable%.exe
copy build\x64\%executable%.exe build\x32\%executable%.exe

for /R %love_path_64% %%f in (*.dll) do copy "%%f" "build\x64\"
for /R %love_path_86% %%f in (*.dll) do copy "%%f" "build\x32\"

:: Cleanup
rmdir /s /q tmp 

build\x64\%executable%.exe