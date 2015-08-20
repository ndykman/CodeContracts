rem @echo off

if "%1" == "" goto usage

pushd Microsoft.VisualStudio.CodeTools\CodeToolsSetup

echo "Building MSM Task"
call buildMSM %1 release %2
if errorlevel 1 goto Failed

echo "Building Export Task"
call export release
if errorlevel 1 goto Failed

popd
pushd Microsoft.Research\ManagedContract.Setup

echo "Building MSI Task"
call buildmsi %1 devlab9ts
if errorlevel 1 goto Failed

echo "Building NuGet Task"
call buildnuget %1 devlab9ts 
if errorlevel 1 goto Failed

popd
echo .
echo ****************************************************
echo Done building CodeContracts version %1
echo ****************************************************
exit /b 0

:Failed
popd
echo .
echo ****************************************************
echo Build FAILED
echo ****************************************************
exit /b 1

:usage

echo buildCC.bat versionNumber [vsVersion]
echo versionNumber (required) is either:
echo   Major revision: major.minor.release (for example 1.9.1)
echo   Minor revision major.minor.release{monthofday}{day}.buildCount
echo     where month of day is the two digit month of the build (August is 08, November is 11)
echo     where day is the two digit day of the month of the build (the 7th is 07, 15th is 15)
echo     For example: The second candidate build on August 14 targeting a 1.9.2 release would have a number 1.9.20814.2
echo vsVersion (optional):
echo   set to 12 to use Visual Studio 12 (2013) build toolchain.
echo   set to 14 to use Visual Studio 14 (2015) build toolchain.

exit /b 1

:end