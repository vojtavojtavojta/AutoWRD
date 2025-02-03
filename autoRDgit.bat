@echo off

echo Auto Remote desktop is starting...

set USERNAME=sshusername
set HOST=hostipaddress
set COMMANDS="cd "C:\Program Files\WakeOnLAN" && WakeOnLanC -w -mac MACADDRESSOFTARGETPC "
set TARGET_PC=targetpcipaddress
set TARGET_VPN_SERVER=vpndhcpserveripaddress

ping -n 2 %TARGET_VPN_SERVER% | find "Reply from" >nul
if %ERRORLEVEL% neq 0 (
    echo Starting VPN connection...
    start /b "" "C:\Program Files\OpenVPN\bin\openvpn-gui.exe" --show_balloon 0 --silent_connection 1 --command connect "openvpnconfig.ovpn"
    @TIMEOUT /T 10 /NOBREAK >nul
)

ping -n 2 %TARGET_PC% | find "Reply from %TARGET_PC%" >nul
if %ERRORLEVEL% equ 0 (
    echo Target PC is already available, connecting...
    mstsc /v:%TARGET_PC%
    exit /b 0
)

echo.
ssh -o StrictHostKeyChecking=no %USERNAME%@%HOST% %COMMANDS%

if %ERRORLEVEL% neq 0 (
    echo An error has occured in connecting to the ssh server
    pause
    exit /b 1
)

echo Wait for the target PC to be available...

@TIMEOUT /T 15 /NOBREAK >nul

echo Connecting...
mstsc /v:%TARGET_PC%