@echo off

if "%1" == "" goto usage

msbuild buildSDK.xml /p:CCNetLabel=%1 /p:ReleaseConfig=%2 /t:All
goto end

:usage
echo buildSDK.bat versionNumber [releaseConfiguration]
echo versionNumber (required) is either:
echo   Major revision: major.minor.release (for example 1.9.1)
echo   Minor revision major.minor.release{monthofday}{day}.buildCount
echo     where month of day is the two digit month of the build (August is 08, November is 11)
echo     where day is the two digit day of the month of the build (the 7th is 07, 15th is 15)
echo     For example: The second candidate build on August 14 targeting a 1.9.2 release would have a number 1.9.20814.2
echo releaseConfig (optional) is a supported release configuration. Defaults to release.

exit /b 1

:end

exit /b 0
