#!/bin/sh
window_W="59%"
window_H="13%"
position_X="50%"
position_Y="95%"

direction="up"
action="toggle"

frame_time=0
step=10
while [ $# -gt 0 ]; do
    case "$1" in
        -i  | --window-id)
            window_id="$2"
            shift 2             ;;
        -D  | --direction)
            accis="1"
            direction="$2"
            shift 2             ;;
        -f  | --frame-time)
            frame_time="$2"
            shift 2             ;;
        -s  | --step)
            step="$2"
            shift 2             ;;
        -dW | --display-width)
            display_W="$2"
            shift 2             ;;
        -dH | --display-height)
            display_H="$2"
            shift 2             ;;
        -pX | --positon-x)
            position_X="$2"
            shift 2             ;;
        -pY | --position-y)
            position_Y="$2"
            shift 2             ;;
        -wW | --window-width)
            window_W="$2"
            shift 2             ;;
        -wH | --window-height)
            window_H="$2"
            shift 2             ;;
        open)
            action="$1"
            shift 1             ;;
        close)
            action="$1"
            shift 1             ;;
        toggle)
            action="$1"
            shift 1             ;;
        -h  | --help) cat << EOF
This script animates the window with given ID using i3-msg.
i3-animate.sh -i "INT" -D up|down|left|right [OPTIONS] open|close|toggle

-i |--windowid       INT                specify the ID of the window (necessary)
-D |--direction      up|down|right|left The direction of window while opening. for closing assumed the opposite
-f |--frametime      INT                The time between frames (sleep command syntaxsis applied).
-s |--step           INT                Ammount of pixels window should be moved between frames.
-dW|--display-width  INT                The width  of the display in pixels.
-dH|--display-height INT                The height of the display in pixels.
-pY|--positionY      INT|INT%           Y coordinate of the upper left corner of the window.
-pX|--positionX      INT|INT%           X coordinate of the upper left corner of the window.
-wW|--window-width   INT|INT%           The width  of the window in pixels or percentage from the screen.
-wH|--window-height  INT|INT%           The height of the window in pixels or percentage from the screen.
-h |--help                              Print this message.
open                                    Command to animate the oppening of given window.
close                                   Command to animate the closing of given window.
toggle                                  Command to change between states.

Note that window is considered to be closed if it is placed in scratchpad
And that "scratchpad show" also works as toggle, which means that two "openings" in a row will cause window to be hidden without animation.
EOF
                exit            ;;
        *)  if [ "$1" -eq "$1" ]; then
                window_id="$1"
                break
            else
                echo "Argument \"$1\" not recognised. Maybe read --help?"
                exit 2
        fi                          ;;
    esac
done


#==== Default varuables
if [ -z "$window_id" ]; then
    echo "No ID specified"
    exit 1
fi

# Getting screen size
# Should be broken with multiple monitors
eval "$( i3-msg -t get_outputs |\
         jq -r '.[] | select(.active==true)|"display_W=${display_W:=\(.rect.width)}\ndisplay_H=${display_H:=\(.rect.height)}"' )"


#==== Calculating values
if echo "$window_W" | grep -q '%'; then
    window_W=$(( ( display_W * ${window_W%\%} ) / 100 ))
fi
if echo "$window_H" | grep -q '%'; then
    window_H=$(( ( display_H * ${window_H%\%} ) / 100 ))
fi


if echo "$position_X" | grep -q '%'; then
    position_X=$(( ( ( display_W - window_W ) * ${position_X%\%} ) / 100 ))
fi
if echo "$position_Y" | grep -q '%'; then
    position_Y=$(( ( ( display_H - window_H ) * ${position_Y%\%} ) / 100 ))
fi

case "$direction" in
    up)    opening="up"
           closing="down"
           start_X=$position_X
           start_Y=$(( $position_Y + $window_H ))
           distance=$window_H
           ;;
    down)  opening="down"
           closing="up"
           start_X=$position_X
           start_Y=$(( $position_Y - $window_H ))
           distance=$window_H
           ;;
    right) opening="right"
           closing="left"
           start_X=$(( $position_X - $window_W ))
           start_Y=$position_Y
           distance=$window_W
           ;;
    left)  opening="left"
           closing="right"
           start_X=$(( $position_X + $window_W ))
           start_Y=$position_Y
           distance=$window_W
           ;;
esac

# Checking if window is in scratchpad
if i3-msg -t get_tree |\
    jq -r "recurse(.nodes[]?)|\
           select(.name == \"__i3_scratch\")|\
           [(.nodes, .floating_nodes)[].nodes[].window] |\
           if index("$window_id") == null then halt_error else halt end" > /dev/null 2>&1
    then
    state="hidden"
else
    state="open"
fi


animate() {
    local direction=$1

    # distance should be equal $window_H/W, but it is not because of integers
    until [ "$distance" -lt 0 ] ; do
        i3-msg -q "[id=$window_id] move $direction $step"
        distance=$(( distance - step ))
        sleep "$frame_time"
    done
}

open() {
        i3-msg -q "[id=$window_id] scratchpad show                                                    ;\
                   [id=$window_id] resize set $window_W $window_H                                     ;\
                   [id=$window_id] move absolute position $start_X $start_Y                           "
        animate $opening
}

close() {
        i3-msg -q  "[id=$window_id] floating enable                                                   ;\
                    [id=$window_id] resize set $window_W $window_H                                    "
        animate $closing
        i3-msg -q  "[id=$window_id] move absolute position $(( $display_W - 1 )) $(( $display_H - 1 ));\
                    [id=$window_id] move scratchpad                                                   "
}


case "$action" in
    open)   open                ;;
    close)  close               ;;
    toggle) case "$state" in
                open)   close   ;;
                hidden) open    ;;
            esac                ;;

esac
