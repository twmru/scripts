# This files is to make your touchpad disabled when mouse connected (Sway)

## 1) Copy following files to directories, if there is no directory, make it.

`97-touchpad.rules` --->  `/etc/udev/rules.d/97-touchpad.rules`
`touchpad` ---> `/etc/udev/scripts/touchpad`
`touchpad_check` ---> somewhere to your $PATH

## 2) Make scripts executable

## 3) Reload udev rules

```
# udevadm control --reload-rules
```

## 4) Put `touchpad_check` script somewhere to autostart.

### I put it to `~/.config/sway/config`:
```
# check mouse connection when sway starts
exec_always ~/.local/bin/touchpad_check
```
## 5) Enjoy.
