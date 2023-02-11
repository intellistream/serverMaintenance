#usage: run as default normal user sutd, specify the name of host vpn file as $1
sudo rsync -avz shuhao@172.18.19.147:/largeData/vpnFiles/$1 /etc/openvpn
sudo apt-get install openvpn
echo "sudo openvpn /etc/openvpn/$1 &" >> /home/sutd/.bashrc
sudo openvpn /etc/openvpn/$1