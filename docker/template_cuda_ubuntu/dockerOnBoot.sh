#!/bin/bash
#usage : ./dockerOnBoot.sh, please run under the normal user who create the docker env
rm envokeDockerCli.sh
echo "#!/bin/bash
mapfile dockerNames </home/$USER/docker_names
for element in ${dockerNames[@]}
#也可以写成for element in ${array[*]}
do
echo "start docker" $element
sudo docker start $element
done" >> envokeDockerCli.sh
sudo cp myDockerCli.service /lib/systemd/system/
sudo cp envokeDockerCli.sh /usr/bin
sudo chmod +x /usr/bin/envokeDockerCli.sh
#sudo /usr/bin/frpc -c /etc/openvpn/frpc_vpn.ini &
sudo systemctl enable myDockerCli
sudo sysctl -p 
sudo service myDockerCli start