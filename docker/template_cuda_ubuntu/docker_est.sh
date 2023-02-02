sudo docker build . -t intelli_u2204_cuda11_7:latest
#docker cp sshd_config intelli_u2204_cuda11_7:/etc/ssh/
sudo docker run --privileged=true --gpus all --name="test_port21195" -h sutd -it intelli_u2204_cuda11_7


