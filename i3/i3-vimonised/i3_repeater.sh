#! /bin/sh
command=$(i3-msg -t subscribe '["binding"]' | jq -r '.binding.command'); # getting a command to repeat
times=$1
until [ $times -lt 2 ]; do
    sleep $2 #might me usefull, was used for debug
    i3-msg "$command"
    times=$(expr $times - 1 )
done
