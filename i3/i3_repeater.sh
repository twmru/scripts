#! /bin/bash
command=$(i3-msg -t subscribe '["binding"]' | jq -r '.binding.command');
times=$1
until [ $times -lt 2 ]; do
    echo $times
    echo $command
    sleep $2
    i3-msg "$command"
    times=$(echo "$times - 1" | bc)
done
