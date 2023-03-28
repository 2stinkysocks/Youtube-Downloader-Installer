@echo OFF
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Running as Administrator, continuing...
) ELSE (
   echo ERROR: This script must be run as an Administrator.
   PAUSE
   EXIT /B 1
)

echo ###############################################
echo #                 IMPORTANT                   #
echo #                                             #
echo # This program requires node to be installed  #
echo # on your computer                            #
echo #                                             #
echo # Current versions of nvm and npm will be     #
echo # replaced                                    #
echo #                                             #
echo ###############################################
pause

if exist %APPDATA%\nvm (
    rmdir /s /q %APPDATA%\nvm
    echo deleting old nvm...
)

if exist "C:\Users\Program Files\nodejs" (
    rmdir /s /q "C:\Users\Program Files\nodejs"
    echo deleting old npm...
)

if exist "C:\Windows\videodownloader.cmd" (
    del /f "C:\Windows\videodownloader.cmd"
    echo deleting old script...
)

mkdir %APPDATA%\nvm
echo Downloading nvm...
powershell -command "curl -o C:\nvm.zip \"https://github.com/coreybutler/nvm-windows/releases/download/1.1.10/nvm-noinstall.zip\""
echo Extracting...
powershell -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%APPDATA%\nvm'); $zip = $shell.NameSpace('C:\nvm.zip'); $target.CopyHere($zip.Items(), 16); }"
set NVM_HOME=%APPDATA%\nvm
echo Downloading and installing npm...
echo root: %APPDATA%\nvm > %APPDATA%\nvm\settings.txt
echo path: C:\Program Files\nodejs >> %APPDATA%\nvm\settings.txt
echo arch: 64 >> %APPDATA%\nvm\settings.txt
echo proxy: none >> %APPDATA%\nvm\settings.txt
echo Wrote settings to file
powershell -command "%APPDATA%\nvm\nvm.exe install 19.8.1"
set NODE_HOME="%APPDATA%\nvm\v19.8.1"
SET INSTALLER_PATH=%~dp0
echo node successfully installed to %NODE_HOME%
echo Installing ytdl...
powershell -command "%NODE_HOME%\npm.cmd i ytdl -g"
echo Installing script...
powershell -command "curl -o C:\Windows\videodownloader.cmd \"https://raw.githubusercontent.com/2stinkysocks/Youtube-Downloader-Installer/master/videodownloader.cmd\""
echo Cleaning up...
del /f C:\nvm.zip
echo ###############################################
echo #                  Success!                   #
echo #                                             #
echo # To run the downloader, press Windows key+R  #
echo # and type `videodownloader`                  #
echo #                                             #
echo ###############################################