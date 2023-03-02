#usage: run as default normal user sutd, specify the name of host vpn file as $1
mkdir /home/sutd/openvpn
rsync -avz shuhao@172.18.19.147:/largeData/vpnFiles/$1 /home/sutd/openvpn
sudo apt-get install openvpn
echo "sudo openvpn /home/sutd/openvpn/$1 &" >> /home/sutd/.bashrc
sudo openvpn /home/sutd/openvpn/$1 &