@echo off
echo %TARGET%
echo %COMPILER%
echo !-----
@set PATH=%PATH%;"C:\Program Files (x86)\Microsoft Visual Studio\Installer\"
@vswhere.exe >NUL || cinst vswhere || exit /b
echo !-----
vswhere -latest
echo !-----
vswhere -legacy