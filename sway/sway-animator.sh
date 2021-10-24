#!/bin/sh
window_W="59%"
window_H="13%"
position_X="50%"
position_Y="95%"

opening="up"
closing="down"

frame_time=0
step=9
while [ $# -gt 0 ]; do
    case "$1" in
        -i  | --window-id)
            window_id="$2"
            shift 2             ;;
        -V  | --vertical)
            accis="1"
            direction="$2"
            shift 2             ;;
        -H  | --horisontal)
            accis="0"
            direction="$2"
            shift 2             ;;
        -ft | --frame-time)
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
This script animates the window with given ID using swaymsg.
i3-animate.sh -i "INT" -h|-v [OPTIONS] open|close|toggle

-i |--windowid       INT         specify the ID of the window (necessary)
-v |--vertical       up|down     Vertical "opening" in the direction of the argument.
-h |--horisontal     right|left  Horisontal "opening" in direction of the argument.
-ft|--frametime      INT         The time between frames (sleep command syntaxsis applied).
-s |--step           INT         Ammount of pixels window should be moved between frames
-dW|--displaywidth   INT         The width of the display in pixels.
-dH|--displayheight  INT         The height of the display in pixels.
-pY|--positionY      INT|INT%    Y coordinate of the upper left corner of the window.
-pX|--positionX      INT|INT%    X coordinate of the upper left corner of the window.
-wW|--windowwidth    INT|INT%    The width of the window in pixels.
-wH|--windowwidth    INT|INT%    The height of the window in pixels.
-h |--help                       Print this message.
open                             Command to animate the oppening of given window.
close                            Command to animate the closing of given window.
toggle                           Command to change between states.

Note that window is considered to be closed if it is placed in scratchpad
And that "scratchpad show" also works as toggle, which means that two "openings" in a row will cause window to be hidden without animation.
EOF
                exit            ;;
        *)  echo "Argument \"$1\" not recognised. Maybe read --help?"
            exit 2              ;;
    esac
done


#==== Default varuables
if [ -z "$window_id" ]; then
    echo "No ID specified"
    exit 1
fi

# Getting screen size
# Should be broken with multiple monitors
if [ -z "$display_W" ]; then
    eval "$( swaymsg -t get_outputs |\
             jq -r '.[] | select(.active==true)|"display_W=\(.rect.width)"')"
fi
if [ -z "$display_H" ]; then
    eval "$( swaymsg -t get_outputs |\
             jq -r '.[] | select(.active==true)|"display_H=\(.rect.height)"')"
fi


#==== Calculating values
if echo $window_W | grep -q '%'; then
    window_W=$(( ( display_W * ${window_W%\%} ) / 100 ))
fi
if echo $window_H | grep -q '%'; then
    window_H=$(( ( display_H * ${window_H%\%} ) / 100 ))
fi


if echo $position_X | grep -q '%'; then
    position_X=$(( (( display_W - window_W ) * ${position_X%\%} ) / 100 ))
fi
if echo $position_Y | grep -q '%'; then
    position_Y=$(( (( display_H - window_H ) * ${position_Y%\%} ) / 100 ))
fi

case $accis in
    1) cur_cor=$window_H ;;
    0) cur_cor=$window_W ;;
esac

case "$direction" in
    up)    opening="up"
           closing="down"
           start_X=$position_X
           start_Y=$(( $position_Y + $window_H ))
           ;;
    down)  opening="down"
           closing="up"
           start_X=$position_X
           start_Y=$(( $position_Y - $window_H ))
           ;;
    right) opening="right"
           closing="left"
           start_X=$(( $position_X - $window_W ))
           start_Y=$position_Y
           ;;
    left)  opening="left"
           closing="right"
           start_X=$(( $position_X + $window_W ))
           start_Y=$position_Y
           ;;
esac


animate() {
    local direction=$1

    # distance should be equal $window_H/W, but it is not because of integers
    until [ $cur_cor -lt 0 ] ; do
        swaymsg -q [id=$window_id] move "$direction" "$step"
        cur_cor=$(( cur_cor - step ))
        sleep $frame_time
    done
}

open() {
        swaymsg -q "[id=$window_id] scratchpad show                                                    ;\
                   [id=$window_id] resize set $window_W $window_H                                     ;\
                   [id=$window_id] move absolute position $start_X $start_Y"
        animate $opening
}

close() {
        swaymsg -q  "[id=$window_id] floating enable                                                   ;\
                    [id=$window_id] resize set $window_W $window_H"
        animate $closing
        swaymsg -q  "[id=$window_id] move absolute position $(( $display_W - 1 )) $(( $display_H - 1 ));\
                    [id=$window_id] move scratchpad"
}


case "$action" in
    open)   open                ;;
    close)  close               ;;
    toggle) case "$state" in
                open)   close   ;;
                closed) open    ;;
            esac                ;;

esac
