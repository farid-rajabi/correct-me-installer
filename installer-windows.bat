@ECHO OFF

NET session >nul 2>&1
IF %ERRORLEVEL% == 0 (
    ECHO Installing the application...
) ELSE (
    ECHO [%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,8%] Installing the Python requirements...
pip3 install -r .\requirements.txt
	SET /p "TEMP=Press Enter to continue..."
)

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
IF '%ERRORLEVEL%' NEQ '0' (
    ECHO Requesting administrative privileges...
    goto UACPrompt
) ELSE ( goto gotAdmin )

:UACPrompt
    ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    SET params= %*
    ECHO UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    DEL "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

SET "APP_DIR=C:\Program Files\Correct Me"
ECHO [%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,8%] Creating the directory... (%APP_DIR%)
IF EXIST "%APP_DIR%" (
    ECHO The directory already exists. Uninstall the existing version and run this installer again...
    ECHO [%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,8%] Installation failed.
    SET /p "TEMP=Press Enter to exit..."
    EXIT 1
)
MKDIR "%APP_DIR%"
CD %APP_DIR%

ECHO [%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,8%] Downloading...
SET "ZIP_FILE=main.zip"
powershell -c "Invoke-WebRequest https://github.com/farid-rajabi/correct-me/archive/refs/heads/main.zip -o %ZIP_FILE%"
ECHO [%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,8%] Extracting...
powershell -c "Expand-Archive %ZIP_FILE% ."

ECHO [%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,8%] Tidying up...
DEL %ZIP_FILE%
FOR /f "delims=" %%i IN ('DIR /a:d /b') DO SET EXTRACTED_DIR=%%i
powershell -c "MOVE .\%EXTRACTED_DIR%\* ."
RMDIR /S /Q .\%EXTRACTED_DIR%
RMDIR /S /Q .\screenshots
DEL .gitignore

ECHO [%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,8%] Creating the executable...
ECHO CLS > "%APP_DIR%\CorrectMe.bat"
ECHO CD "%APP_DIR%" >> "%APP_DIR%\CorrectMe.bat"
ECHO python .\bin\main.py >> "%APP_DIR%\CorrectMe.bat"

ECHO [%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,8%] Creating the shortcut...
SET SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
ECHO Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
ECHO sLinkFile = "%USERPROFILE%\Desktop\Correct Me!.lnk" >> %SCRIPT%
ECHO Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
ECHO oLink.TargetPath = "%APP_DIR%\CorrectMe.bat" >> %SCRIPT%
ECHO oLink.IconLocation = "%APP_DIR%\icon.ico"
ECHO oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
DEL %SCRIPT%

ECHO [%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% %TIME:~0,8%] Installation completed.
SET /p "TEMP=Press Enter to exit..."
EXIT 0
