#! /bin/bash
# variables
X=${X:=0}
Y=${Y:=0}
window_x=${window_x:=0}
window_y=${window_y:=0}
window_width=${window_width:=2}
window_height=${window_height:=2}
instance=${instance:=$TERM}
window_count=$(i3-msg -t get_tree | jq -r '.. | .nodes?[]? | select(.window_type == "normal") | .name' | wc -l)
# getting cursor coordinates
eval $(xdotool getmouselocation --shell)
# getting window coordinates and dimentions
eval $( i3-msg -t get_tree | jq -r '..|try select(.focused == true)| "window_x=\(.rect.x)\nwindow_y=\(.rect.y)\nwindow_width=\(.rect.width)\nwindow_height=\(.rect.height)\ninstance=\(.window_properties.instance)"' )

waitloop(){
    until [ $window_count -lt $new_window_count ];
    do
        new_window_count=$(i3-msg -t get_tree | jq -r '.. | .nodes?[]? | select(.window_type == "normal") | .name' | wc -l)
        sleep 0.1
    done
}

slicing(){
    change=$(( $1 / 2 - ($2 - $3) ))
    i3-msg split "$5" && $instance & disown && waitloop
    if [ "$change" -gt 0 ]; then
        i3-msg resize grow "$4" "$change"
    else
        change=$(( change* - 1 ))
        i3-msg resize shrink "$4" "$change"
    fi
}

if [ "$1" = "hor" ]; then slicing $window_height $Y $window_y height v
elif [ "$1" = "ver" ]; then slicing $window_width $X $window_x width h
fi


# Author: Karakurt
# Idea: foggalong ( https://www.reddit.com/r/unixporn/comments/8oj2a2/bspwm_slicing_windows/ )
# TODO
#  -  find a way to not depend on focused window

