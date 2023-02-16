#usage ./docker_run.sh [name of container], as normal admin user
sudo docker start $1
sudo docker attach $1
