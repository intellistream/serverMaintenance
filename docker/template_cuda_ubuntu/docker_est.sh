docker build . -t adb_u2204_cuda11_7:latest
docker cp sshd_config adb_u2204_cuda11_7:/etc/ssh/
docker run --privileged --mount source=rootfs,target=/home/sutd/project --name="aliancedb_u22_04_a" -h sutd -it adb_u2204_cuda11_7

