@echo off

if "%1" == "" goto usage

setlocal enabledelayedexpansion

if "%3" == "" SET vs=10

if "%3" == "14" SET vs=14

rem Make sure NuGet packages are restored before proceeding with the build
..\..\.nuget\NuGet.exe restore ..\CodeTools%vs%.sln
if errorlevel 1 exit /b 1

rem Also need to restore packages from the top-level solution before building CodeTools
..\..\.nuget\NuGet.exe restore ..\..\CodeContracts.sln
if errorlevel 1 exit /b 1

if "%2" == "" goto default
if "%2" == "export" goto export

msbuild buildMSM%vs%.xml /p:CCNetLabel=%1 /p:ReleaseConfig=%2 /t:All
if errorlevel 1 exit /b 1
goto end

:default
msbuild buildMSM%vs%.xml /p:CCNetLabel=%1 /p:ReleaseConfig=release /t:All
if errorlevel 1 exit /b 1

call export release
if errorlevel 1 exit /b 1

goto end

:export

regasm /tlb ..\ITaskManager\bin\Release\ITaskManager.dll
if errorlevel 1 exit /b 1

sd edit ..\TLB\ITaskManager.tlb
if errorlevel 1 exit /b 1

copy /y ..\ITaskManager\bin\Release\ITaskManager.tlb ..\TLB
if errorlevel 1 exit /b 1

msbuild buildMSM%vs.xml /p:CCNetLabel=%1 /p:ReleaseConfig=release /t:Export
if errorlevel 1 exit /b 1

:usage

endlocal

echo buildMSN.bat versionNumber [releaseConfig] [vsVersion]
echo versionNumber (required) is either:
echo   Major revision: major.minor.release (for example 1.9.1)
echo   Minor revision major.minor.release{monthofday}{day}.buildCount
echo     where month of day is the two digit month of the build (August is 08, November is 11)
echo     where day is the two digit day of the month of the build (the 7th is 07, 15th is 15)
echo     For example: The second candidate build on August 14 targeting a 1.9.2 release would have a number 1.9.20814.2
echo releaseConfig (optional) is a supported release configuration. Defaults to release.
echo vsVersion (optional) set to 14 to use Visual Studio 14 (2015) build toolchain.

exit /b 1

:end

endlocal

exit /b 0
