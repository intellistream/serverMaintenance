#/bin/bash
#note: run this as normal user, no sudo
PREFIX="$(cat /etc/openvpn/myPort.txt)"
USERNAME="VPNPORT-$PREFIX-$1"
echo $USERNAME
sudo bash openvpn-new_cli.sh $USERNAME
#sshpass -p "password" rsync --progress -avz /home/sutd/$USERNAME.ovpn -e ssh shuhao@172.18.19.136:/largeData/vpnFiles
rsync  -avz /home/sutd/$USERNAME.ovpn shuhao@172.18.19.136:/largeData/vpnFiles

