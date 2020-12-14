#! /bin/sh
command=$(i3-msg -t subscribe '["binding"]' | jq -r '.binding.command'); # getting a command to repeat
times=$1
until [ $times -lt 2 ]; do
    #echo $times
    #echo $command
    sleep $2 #might me usefull, was used for debug
    i3-msg "$command"
    times=$(echo "$times - 1" | bc)
done
