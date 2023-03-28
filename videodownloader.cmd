@echo off

echo ###############################################
echo #             YouTube Downloader              #
echo ###############################################

set /p "url=Video URL > "
set /p "name=Output Filename > "
powershell -command "%APPDATA%\nvm\v19.8.1\npx.cmd ytdl %url% --filter audioandvideo -o %USERPROFILE%\Downloads\%name%"
echo Saved to Downloads
pause >nul
