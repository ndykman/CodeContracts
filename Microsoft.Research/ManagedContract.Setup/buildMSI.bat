@echo off

rem if no version number was passed, exit with an error. 
if "%1" == "" goto usage 

rem Make sure NuGet packages are restored before proceeding with the build
..\..\.nuget\NuGet.exe restore ..\..\CodeContracts.sln
if errorlevel 1 exit /b 1

rem Assume a default debug build
if "%2" == "" goto default

echo Build %2 version (%1)
msbuild buildMSI10.xml /p:CCNetLabel=%1 /p:ReleaseConfig=%2 /t:All %3
if errorlevel 1 exit /b 1

goto end

:default
echo build debug version (%1)
msbuild buildMSI10.xml /p:CCNetLabel=%1 /p:ReleaseConfig=debug /t:All
if errorlevel 1 exit /b 1

goto end

:usage

echo buildMSI.bat versionNumber
echo versionNumber (required) is either:
echo   Major revision: major.minor.release (for example 1.9.1)
echo   Minor revision major.minor.release{monthofday}{day}.buildCount
echo     where month of day is the two digit month of the build (August is 08, November is 11)
echo     where day is the two digit day of the month of the build (the 7th is 07, 15th is 15)
echo     For example: The second candidate build on August 14 targeting a 1.9.2 release would have a number 1.9.20814.2

exit /b 1

:end

exit /b 0