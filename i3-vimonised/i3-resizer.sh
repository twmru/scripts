#!/bin/bash
case $1 in
    h) i3-msg resize shrink width $number;;
    j) i3-msg resize shrink height $number;;
    k) i3-msg resize grow height $number;;
    l) i3-msg resize grow width $number;;
    [0-9])  number=$( tail -n 1 "$2");
            number=$number$1;
            echo $number > $2 ;;
esac
