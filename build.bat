@echo off

if "%1" == "" goto usage

call buildCC %1 %2
if errorlevel 1 exit /b 1
goto end

:usage

echo build.bat versionNumber [vsVersion]
echo versionNumber (required) is either:
echo   Major revision: major.minor.release (for example 1.9.1)
echo   Minor revision major.minor.release{monthofday}{day}.buildCount
echo     where month of day is the two digit month of the build (August is 08, November is 11)
echo     where day is the two digit day of the month of the build (the 7th is 07, 15th is 15)
echo     For example: The second candidate build on August 14 targeting a 1.9.2 release would have a number 1.9.20814.2
echo vsVersion (optional) set to 14 to use Visual Studio 14 (2015) build toolchain.

:end
