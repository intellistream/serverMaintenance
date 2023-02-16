#usage ./docker_del.sh [name of container], as normal admin user
sudo docker container stop $1
sudo docker container rm  $1


