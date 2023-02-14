#!/bin/bash
mapfile dockerNames <docker_names
for element in ${dockerNames[@]}
#也可以写成for element in ${array[*]}
do
echo "stop docker" $element
sudo docker stop $element
done