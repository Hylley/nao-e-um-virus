@echo off
chcp 65001

:: Prepare the project root folder
mkdir tmp & rmdir /s /q build

:: Build
mkdir build
set love_path_x64="C:\Program Files\LOVE\"
set love_path_x86="C:\Program Files (x86)\LOVE"
if not exist %love_path_x64% echo Love framework (x64) is non-existent. It was not installed or is in a different path. & exit 1
if not exist %love_path_x86% echo Love framework (x86) is non-existent. It was not installed or is in a different path. & exit 1
set executable=não-é-um-vírus

mkdir build\x64 & mkdir build\x86

powershell Compress-Archive -Path src\* -DestinationPath tmp\out.zip
cd tmp && ren *.zip *.love && cd ..

copy /b %love_path_x64%love.exe + "tmp\out.love" build\x64\%executable%.exe
copy build\x64\%executable%.exe build\x86\%executable%.exe

for /R %love_path_x64% %%f in (*.dll) do copy "%%f" "build\x64\"
for /R %love_path_x86% %%f in (*.dll) do copy "%%f" "build\x86\"

:: Apply resources

:: Cleanup
rmdir /s /q tmp