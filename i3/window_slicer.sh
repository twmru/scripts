#! /bin/dash
# getting cursor coordinates
eval $(xdotool getmouselocation --shell)
# getting window coordinates and dimentions
eval $( i3-msg -t get_tree | jq -r '..|try select(.focused == true)| .rect | "window_x=\(.x)\nwindow_y=\(.y)\nwindow_width=\(.width)\nwindow_height=\(.height)"' )

if [ "$1" = "horiz" ]; then
    change=$(echo "$window_height / 2 - ($Y - $window_y)" | bc )
    i3-msg split v && kitty --detach && sleep 0.1 # waiting for kitty to be launched
    if [ "$change" -gt 0 ]; then
        i3-msg resize grow height "$change"
    else
        change=$(echo "$change*-1" |bc)
        i3-msg resize shrink height "$change"
    fi

elif [ "$1" = "vert" ]; then
    change=$(echo "$window_width / 2 - ($X - $window_x)" | bc )
    i3-msg split h && kitty --detach && sleep 0.15 # waiting for kitty to be launched
    if [ "$change" -gt 0 ]; then
        i3-msg resize grow width "$change"
    else
        change=$(echo "$change*-1" |bc)
        i3-msg resize shrink width "$change"
    fi
fi
# Author: Karakurt
# Idea: foggalong ( https://www.reddit.com/r/unixporn/comments/8oj2a2/bspwm_slicing_windows/ )
# TODO
#  -  fix timeout for terminal
#  -  port to dash
#  -  add window duplication instead of terminal spam

