sudo apt-get install curl -y
curl https://get.docker.com | sh \
  && sudo systemctl --now enable docker
#distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
sudo systemctl restart docker
