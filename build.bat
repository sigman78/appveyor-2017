@echo off
if DEFINED "%TARGET%" echo %TARGET%:%COMPILER%

echo !----1
@set "PATH=%PATH%;C:\Program Files (x86)\Microsoft Visual Studio\Installer\"
@rem seems like 1.0.62 differs in command line vs 1.0.71 in choco repository
@vswhere.exe >NUL || cinst vswhere --version 1.0.62 || exit /b


echo !----2
vswhere -latest
echo !----3
vswhere -legacy
echo !----4
vswhere -nologo -legacy -version [14,16) -property installationPath
echo !----5
vswhere -nologo -legacy -version [14^,16^) -property installationPath

:: works only in 2017 and then legacy, somehow legacy vcvarsall will prevent newer to setup the environment

echo !----- VS 2017

for /f "usebackq tokens=*" %%i in (`vswhere -nologo -version [15^,16^) -property installationPath`) do (
  if exist "%%i" (
    set VS15_DIR=%%i
    set VS15_VCVARSALL=%%i\VC\Auxiliary\Build\vcvarsall.bat
  )     
)

echo "%VS15_VCVARSALL%"
call "%VS15_VCVARSALL%" x64
cl.exe

echo !----- VS 2015

:: for legacy platform (2015) "-version [14^,15^)" arg does not work and reports all legacy tools, but at least in decreasing order
for /f "usebackq tokens=*" %%i in (`vswhere -nologo -version [14^,15^) -legacy -property installationPath`) do (
  if exist "%%i" (
    set VS14_DIR=%%i
    set VS14_VCVARSALL=%%iVC\vcvarsall.bat
    goto stopit
  )     
)
:stopit

echo "%VS14_VCVARSALL%"
call "%VS14_VCVARSALL%" x64
cl.exe

echo Done.
