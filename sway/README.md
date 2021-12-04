### auto_switch_kbd.py

Requirements:

* Python 3
* `i3ipc` python package

Description:

Remembers keyboard layout for each window and restores it  
You need to set the `--kb-id` to your keyboard ID that you can get via `swaymsg -t get_inputs`  
See `--help` for more information

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

* youtube-dl (optional)
* [ytmpv](sway/ytmpv)

Selects search-engine and opens search in browser  
It supports choosing `searx` instance and  
opening youtube video (`youtubev`) via `ytmpv` script

### wsudo

Requirements:

* Xwayland

Description:

Run wayland app in sudo via Xwayland

* Xwayland (optional)

Description:

Run wayland app in other user natively or via Xwayland

### ytmpv

Requirements:

* mpv
* wl-clipboard

Description:

Plays youtube video from clipboard with hardware acceleration


### fzf-images

Requirements:

* fd (can be rewritten to use `find`)
* fzf
* imv

Description:

Opens `imv` in separate window and shows selected image in preview


### tesseractor

Requirements:

* tesseract with rus and eng data
* grim
* slurp
* notify-send
* wl-clipboard
* clipman

Description:

Detects russian and english text on selected area of the screen


### crowscream

Requirements:

* crow-translate
* notify-send
* wl-clipboard
* bemenu

Description:

Translates text from clipboard (or written into menu) and
shows translation in notification


### animator

Requirements:
* jq
<<<<<<< HEAD
=======
* swaymsg
>>>>>>> upstream/main

Description:

Animates window moving along one axis using swaymsg.
