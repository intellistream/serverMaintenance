#usage ./docker_new.sh [name of container], as normal admin user
sudo docker run --privileged=true --gpus all --name="$1" -h sutd -it intelli_u2204_cuda11_7
echo $1 >> ~/docker_names