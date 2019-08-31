@echo off
::MODE con: COLS=165 LINES=65
title 查看WIFI密码 %date% 
::获取管理员权限
setlocal
set uac=~uac_permission_tmp_%random%
md "%SystemRoot%\system32\%uac%" 2>nul
if %errorlevel%==0 ( rd "%SystemRoot%\system32\%uac%" >nul 2>nul ) else (
    echo set uac = CreateObject^("Shell.Application"^)>"%temp%\%uac%.vbs"
    echo uac.ShellExecute "%~s0","","","runas",1 >>"%temp%\%uac%.vbs"
    echo WScript.Quit >>"%temp%\%uac%.vbs"
    "%temp%\%uac%.vbs" /f
    del /f /q "%temp%\%uac%.vbs" & exit )
endlocal
:: ***********************************************************************  我是分割线
netsh wlan show profile
echo   ************************************************************************
echo  提示:以上为本机所连接过WIFI信息
echo   ************************************************************************
:menu
echo.
  set /p var=请输入你要查看密钥WLAN:
if  "%var%"  equ  ""  goto  menu 
if  %var%    equ 15  exit
netsh wlan show profile name="%var%" key=clear >kbc.txt
type kbc.txt | findstr 关键内容
ping /n 10 127.0.0.1 >nul