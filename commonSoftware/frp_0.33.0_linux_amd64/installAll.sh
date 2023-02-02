#/bin/bash
#note: run this as normal user, no sudo
./vpnPortManCli ws://172.18.19.147:9002
sudo mkdir /etc/openvpn
sudo cp myPort.txt /etc/openvpn
sudo bash openvpn-install_no_ui.sh
sudo cp frpc /usr/bin/
./createNewCli.sh entryUser
sudo service openvpn start
sudo /usr/bin/frpc -c /etc/openvpn/frpc_vpn.ini &