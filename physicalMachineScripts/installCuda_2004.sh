# for ubuntu 20.04 only
export distro=ubuntu2004
export arch=x86_64
wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb 
sudo apt-get update
sudo apt-get install cuda-11-7 -y
sudo apt-get install nvidia-gds -y
sudo reboot
