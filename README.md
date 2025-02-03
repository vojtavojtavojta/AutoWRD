# AutoWRD
This is a simple .bat file that automaticaly starts an OpenVPN connection, wakes up a PC using WakeOnLan and initialises a WRD connection to the PC.
Feel free to edit it to your needs
At line 18 i found out that pinging a machine inside the vpn but not offline gives a message "reply from _ipaddressofvpnserver_" so for that you have to have find "reply from _ipaddressofremotepc_"