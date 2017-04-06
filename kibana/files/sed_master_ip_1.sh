#!/bin/bash

filename=/opt/redis_master_1.txt
declare -a myArray
myArray=(`cat "$filename"`)

for (( i = 0 ; i < 1 ; i++))
do
  echo "Element [$i]: ${myArray[$i]}"
done

sed -i 's/master_node_ip_variable/'${myArray[0]}'/g' /opt/kibana/config/kibana.yml

