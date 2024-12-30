@echo off
REM set LOGFILE=%ProgramData%\LogMeIn_Script_Log.txt
set LOGFILE=c:\temp\WMI_Rebuild_Log.txt

echo Log Start at %DATE% %TIME% > "%LOGFILE%"
whoami >> "%LOGFILE%"

REM Navigate to the wbem folder. MOF files are located here.
cd c:\Windows\System32\wbem >> "%LOGFILE%" 2>&1
echo Step 1: Changed directory >> "%LOGFILE%" 2>&1

REM Runs mofcomp for each MOF file excluding "uninstall" in the name.
for /F "tokens=*" %%s in ('dir /b *.mof *.mfl ^| findstr /v /i uninstall') do (
    c:\Windows\System32\wbem\mofcomp.exe %%s >> "%LOGFILE%" 2>&1
)
echo Step 2: Compiled MOF files >> "%LOGFILE%" 2>&1

REM Compile ExtendedStatus.mof.
cd "C:\Program Files\Microsoft Policy Platform" >> "%LOGFILE%" 2>&1
echo Step 3: Changed directory >> "%LOGFILE%" 2>&1
c:\Windows\System32\wbem\mofcomp.exe ExtendedStatus.mof >> "%LOGFILE%" 2>&1
echo Step 4: Compiled ExtendedStatus.mof >> "%LOGFILE%" 2>&1

echo Script Completed at %DATE% %TIME% >> "%LOGFILE%" 2>&1
exit
