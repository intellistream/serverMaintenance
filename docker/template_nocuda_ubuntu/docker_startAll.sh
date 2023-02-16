#!/bin/bash
mapfile dockerNames <~/docker_names
for element in ${dockerNames[@]}
#也可以写成for element in ${array[*]}
do
echo "start docker" $element
sudo docker start $element
done