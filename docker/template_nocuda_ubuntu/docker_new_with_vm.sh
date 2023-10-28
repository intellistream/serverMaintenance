#usage ./docker_new.sh [name of container], as normal admin user
sudo docker run --privileged=true  --name="$1" -h sutd -it --device /dev/vboxdrv:/dev/vboxdrv intelli_u2204_nocuda
echo $1 >> ~/docker_names