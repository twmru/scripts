#! /usr/bin/python

from i3ipc import Connection, Event

sway = Connection()

def on_window_focus(sway, e):
    focused = sway.get_tree().find_focused()
    if focused and focused.app_id in ["telegramdesktop", "nheko", "slack", "appimagekit_d2192f48ebc43a9db26e1dfa2bc5097b-Kotatogram_Desktop"]:
        sway.command("input * xkb_switch_layout 1")
    else:
        sway.command("input * xkb_switch_layout 0")

# sway.on(Event.WINDOW_FOCUS, on_window_focus)
sway.on(Event.WINDOW, on_window_focus)
sway.main()
