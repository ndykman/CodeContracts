@echo off

setlocal
set release=%1
if "%1" == "" set release=release

copy /y %release%\CodeTools.msm ..\..\Microsoft.Research\ImportedCodeTools
if errorlevel 1 goto error

copy /y ..\CodeToolsUpdate\bin\%release%\CodeToolsUpdate.exe ..\..\Microsoft.Research\ImportedCodeTools
if errorlevel 1 goto error 

goto end

:error

endlocal
exit /b 1

:end

endlocal
exit /b 0



