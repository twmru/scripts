## Window Slicer
Script mainly for fun, can "cut" any window based on cursor position

##### Usage:
```window_slicer [hor|ver]```

##### Requirements:
* jq
* xdotool
* any gesture demon (optional)

## Dropdown Terminal
Script to make Guake-like terminal
Forked from https://github.com/ntcarlson/dotfiles/blob/eta/i3/scripts/dropdown_terminal

#### Usage
```./dropdown_terminal <start|open|close|toggle>```

#### Requirements
* any terminal
* xdotool

## Window animator
Generalized version of dropdown terminal, animates window along one axis

#### Usage
```i3-animate.sh -i "INT" -H|-V [OPTIONS] open|close|toggle```
For full list please read skript itself or start it with --help flag

#### Requirements
* jq (optional, used for automatic resolution detection, but needs to be commented out)

## Pin Workspaces
A hacky way to make i3wm keep workspaces even if there are no windows on them

#### Usage
``` i3-workspace-holder.sh start|stop [OPTIONS] -- Name1 Name2 ...```
Options:
    -W | --width      Display width
    -H | --height     Display height
    -h | --help       This message```

#### Requirements
* jq (optional, used for automatic resolution detection, but needs to be commented out)
