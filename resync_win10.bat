@echo off
echo PLEASE QUIT YOUR WALLET BEFORE COUNTINUE!!!
pause

SET mypath=%~dp0
echo %mypath:~0,-1%

IF EXIST wallet.dat (
echo YOU ARE IN THE RIGHT FOLDER!
) ELSE (
ECHO RESYNC.BAT FILE MUST BE IN THE SAME FOLDER AS WALLET.DAT
goto :eof
)

echo Downloading bootstrap
powershell -Command "Invoke-WebRequest http://blockchain.monkey.vision/ -OutFile bootstrap.zip"
:: powershell -Command "(New-Object Net.WebClient).DownloadFile('http://blockchain.monkey.vision/', 'bootstrap.zip')"
echo Bootstrap downloaded

IF EXIST bootstrap.zip (
echo Delete blockchain!
@RD /S /Q "%mypath:~0,-1%\database"
@RD /S /Q "%mypath:~0,-1%\blocks"
@DEL "%mypath:~0,-1%\peers.dat"
echo bootstrap downloaded!
::unzip bootstrap.zip
echo unzipping ...
powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%mypath:~0,-1%'); $zip = $shell.NameSpace('%mypath:~0,-1%\bootstrap.zip'); $target.CopyHere($zip.Items(), 16); }"
echo unzipped

del bootstrap.zip
) ELSE (
echo bootstrap not downloded!
)

echo adding addnode
find /c "addnode=140.72.47.201" monkey.conf
if %errorlevel% equ 1 goto notfound1
echo found
goto done1
:notfound1
echo notfound
echo addnode=140.72.47.201 >> monkey.conf
goto done1
:done1

:: addnode=8.9.3.216
find /c "addnode=8.9.3.216" monkey.conf
if %errorlevel% equ 1 goto notfound2
echo found
goto done2
:notfound2
echo notfound
echo addnode=8.9.3.216 >> monkey.conf
goto done2
:done2

:: addnode=63.209.32.131
find /c "addnode=63.209.32.131" monkey.conf
if %errorlevel% equ 1 goto notfound3
echo found
goto done3
:notfound3
echo notfound
echo addnode=63.209.32.131 >> monkey.conf
goto done3
:done3

echo Finish!
echo YOU CAN RESTART YOUR WALLET NOW!!!
pause

:eof