#! /bin/sh

while [ $# -gt 0 ]; do
    case "$1" in
        start) action="start"; shift;;
        stop)  action="stop"; shift;;
        -W | --width)  display_W="$2"; shift 2;;
        -H | --height) display_H="$2"; shift 2;;
        -h | --help)
            cat << EOF
A script to pin workspaces in i3wm using empty window comtainers
Usage: $0 start|stop [OPTIONS] -- Name1 Name2 ...
Options:
    -W | --width      Display width
    -H | --height     Display height
    -h | --help       This message
EOF
            exit
            ;;

        --) shift; break;;
        *) echo "Unrecognised argument"; exit 2 ;;
    esac
done

if [ -z "$display_W" ]; then
    eval "$( i3-msg -t get_outputs |\
        jq -r '.[] | select(.active==true)|"display_W=\(.rect.width)"')"
fi
if [ -z "$display_H" ]; then
    eval "$( i3-msg -t get_outputs |\
        jq -r '.[] | select(.active==true)|"display_H=\(.rect.height)"')"
fi
X=$(( $display_W - 1 ))
Y=$(( $display_H - 1 ))

while [ $# -gt 0 ]; do
    name="$1"
    if [ $action = "start" ]; then
        i3-msg -q "open, mark "ws_holder_$name", floating enable"
        i3-msg -q "[ con_mark="ws_holder_$name" ] \
            resize set 200 200,\
            move absolute position $X $Y,\
            move workspace "$name""
    else
        i3-msg -q "[ con_mark="ws_holder_$name" ] kill"
    fi
    shift
done
