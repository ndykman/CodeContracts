if %1 = "" goto usage

set TDIR=d:\Public\CodeContracts\%1
set BDIR1=%TDIR%\Unpacked\devlab9ts\Bin
set BDIR2=%TDIR%\Unpacked\msft9\Bin
md %BDIR1% 
md %BDIR2% 
copy devlab9ts\msisigned\* %TDIR%
copy msft9\msisigned\*.msi %TDIR%
copy devlab9ts\tmp\*.exe %BDIR1%
copy devlab9ts\tmp\*.pdb %BDIR1%
copy devlab9ts\tmp\*.exe.config %BDIR1%
copy msft9\tmp\*.exe %BDIR2%
copy msft9\tmp\*.pdb %BDIR2%
copy msft9\tmp\*.exe.config %BDIR2%

usage:

echo saveSignedBits.bat versionNumber
echo versionNumber (required) is either:
echo   Major revision: major.minor.release (for example 1.9.1)
echo   Minor revision major.minor.release{monthofday}{day}.buildCount
echo     where month of day is the two digit month of the build (August is 08, November is 11)
echo     where day is the two digit day of the month of the build (the 7th is 07, 15th is 15)
echo     For example: The second candidate build on August 14 targeting a 1.9.2 release would have a number 1.9.20814.2