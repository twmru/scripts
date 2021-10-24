## Window Slicer
Script mainly for fun, can "cut" any window based on cursor position

##### Usage:
```window_slicer [hor|ver]```

##### Requirements:
* jq
* xdotool
* i3-msg (obviously)
* any gesture demon (optional)

## Dropdown Terminal
Script to make Guake-like terminal
Forked from https://github.com/ntcarlson/dotfiles/blob/eta/i3/scripts/dropdown_terminal

#### Usage
```./dropdown_terminal <start|open|close|toggle>```

#### Requirements
* any terminal
* xdotool
* i3-msg

## Window animator
Generalized version of dropdown terminal, animates window along one axis

#### Usage
```i3-animate.sh -i "INT" -H|-V [OPTIONS] open|close|toggle```
For full list please read skript itself or start it with --help flag

#### Requirements
* i3-msg
* jq (optional, used for automatic resolution detection)
