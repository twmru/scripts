Here are the skripts used in i3-vimonised.
[Main repisitory](https://github.com/0Karakurt0/i3-vimonised)

### Last action
A small demon for storing last command sent to i3

##### Usage:
```
script_name [start|-s|clear|-c|get|-g] /pipe/file/on/disk
```

##### Dependencis
* jq
* grep
* tac
* head
* tail
* tee
* i3-msg

### Repeater
A script for repeating next command to i3-msg

##### Usage:
```
script_name [number] {sleep delay}
```

##### Dependencis
* jq
* i3-msg

### Resizer
A script to make vim-like resizing of windows possible

##### Usage:
```
script_name {h|j|k|l|[0-9]}
```

##### Dependencis
* i3-msg
