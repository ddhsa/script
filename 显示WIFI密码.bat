@echo off
::MODE con: COLS=165 LINES=65
title �鿴WIFI���� %date% 
::��ȡ����ԱȨ��
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
:: ***********************************************************************  ���Ƿָ���
netsh wlan show profile
echo   ************************************************************************
echo  ��ʾ:����Ϊ���������ӹ�WIFI��Ϣ
echo   ************************************************************************
:menu
echo.
  set /p var=��������Ҫ�鿴��ԿWLAN:
if  "%var%"  equ  ""  goto  menu 
if  %var%    equ 15  exit
netsh wlan show profile name="%var%" key=clear >kbc.txt
type kbc.txt | findstr �ؼ�����
ping /n 10 127.0.0.1 >nul