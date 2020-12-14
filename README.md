# Scripts collection

## Welcome

This is a script collection from Russian Tiling WM Community  
You can find various scripts for different tiling wms here  
If you want to contribute, read CONTRIBUTION.md guidelines first

---

## Scrips for Sway

### auto_switch_kbd.py

Requirements:

* Python 3
* `i3ipc` python package

Description:

Switches keyboard layout from en to ru depending on cureently focues app

### autobtconnect.sh

Requirements:

* bluetoothctl
* `notify-send`

Description:

Toggles bluetooth power state and automatically connects to specified device on "power on".  
Useful for working with bluetooth headsets

### blurlock

Requirements:

* pamixer
* grim
* libvips

Description:

Sets lock screen with blurred workspace on background  
Disables sound before locking screen

### clipboard_action.sh

Requirements:

* wl-clipboard
* bemenu
* awk

Description:

Executes some action from template file located at `~/.local/clipboard_commands.txt`
Template file should have lines with `%s` substring which will be replaced with current item from clipboard
Actions are executed in directory specified in first bemenu prompt, directory is created on demand

### firefox_history_bemenu.sh

Requirements:

* bemenu
* firefox

Description:

Opens bemenu with history of titles of visited websites and opens selected one in bemenu
> You should set profile inside your copy of a script

### get_app_id

Requirements:

* python3
* i3ipc
* `notify-send`

Description:

Shows add_id, class and title of currently focused window in notification

### mpv_music.sh

Requirements:

* bemenu
* mpv

Selects folder and plays music from this folder

### websearch.sh

Requirements:

* bemenu
* s

Selects search-engine and opens search in browser

### wsudo

Requirements:

* Xwayland

Description:

Run wayland app in sudo via Xwayland

### ytmpv

Requirements:

* mpv
* wl-clipboard

Description:

Plays youtube video from clipboard with hardware acceleration
