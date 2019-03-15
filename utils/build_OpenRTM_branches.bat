@echo off
@rem ----------------------------------------------------
@rem Batch for multiple branch build of OpenRTM-aist
@rem
@rem   (Supports OpenRTM version 2.0 or higher.)
@rem
@rem Input Files.
@rem  1) branch-name.txt : Target branch list
@rem     Lines beginning with # are comment statements.
@rem
@rem Output Files.
@rem  1) Log file : log/yymmdd-hhmmss.log
@rem ----------------------------------------------------


set TOP_DIR=%CD%
set VS_VERSION=11
set omniORB=omniORB-4.2.3-win64-vc%VS_VERSION%
set PYTHON_DIR=C:\Python27_x64

set TARGET=OpenRTM-aist
set VC_NAME="Visual Studio %VS_VERSION% Win64"

set CMAKE_OPT=-DOMNI_VERSION=42 ^
              -DOMNI_MINOR=3 ^
              -DOMNITHREAD_VERSION=41 ^
              -DORB_ROOT=%TOP_DIR%\%TARGET%\%omniORB% ^
              -DCORBA=omniORB

set PATH=%PATH%;%PYTHON_DIR%;%ProgramFiles%\Git\bin
set LOG_DIR=log
if not exist %LOG_DIR% mkdir %LOG_DIR%

@rem -------- set Log Files name ----------
set yyyy=%date:~0,4%
set mm=%date:~5,2%
set dd=%date:~8,2%
set time2=%time: =0%
set hh=%time2:~0,2%
set mn=%time2:~3,2%
set ss=%time2:~6,2%
set LOGFILE=%LOG_DIR%\%yyyy%%mm%%dd%-%hh%%mn%%ss%

echo %yyyy%/%mm%/%dd%  %hh%:%mn%:%ss% > %LOGFILE%.log
echo. >> %LOGFILE%.log

setlocal enabledelayedexpansion
for /f %%a in (branch-name.txt) do (
  set branch=%%a
  if not "!branch:~0,1!" == "#" (
    call :SRC_BUILD
  )
)
exit /b

:SRC_BUILD
  echo *-*-*-* !branch!
  cd %TARGET%
  git checkout !branch!
  if ERRORLEVEL 1 (
    echo %branch% : checkout error >> %TOP_DIR%\%LOGFILE%.log
    exit /b
  )
  
  git reset --hard
  git clean -df
  
  @rem ---- src copy
  mkdir src\lib\coil\common\coil
  move src\lib\coil\common\*.* src\lib\coil\common\coil 
  copy build\yat.py utils\rtm-skelwrapper 
  mkdir %omniORB%
  xcopy /e/i/y/q ..\%omniORB% %omniORB%

  mkdir build_omni
  cd build_omni
  cmake  %CMAKE_OPT% -G %VC_NAME% ..
  if ERRORLEVEL 1 (
    echo %branch% : cmake error >> %TOP_DIR%\%LOGFILE%.log
    goto :SRC_BUILD_FINAL
  )
  
  cmake --build . --config Release
  if ERRORLEVEL 1 (
    echo %branch% : build error >> %TOP_DIR%\%LOGFILE%.log
  ) else (
    echo %branch% : OK! >> %TOP_DIR%\%LOGFILE%.log
  )

:SRC_BUILD_FINAL
  cd %TOP_DIR%
exit /b

