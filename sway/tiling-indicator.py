#!/usr/bin/env python3
# vim: autoindent smartindent expandtab smarttab tabstop=4 softtabstop=4 shiftwidth=4 foldmethod=marker :

"""
Show split layout indicator
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Usage::

    ./tiling-indicator.py

Suppoused to be used inside waybar or polybar.

Config example:

Waybar:
=======

.. code-block:: conf

    "custom/ws": {
        "return-type": "json",
        // "exec": "python -u $HOME/.config/waybar/scripts/tiling-indicator-2.py 2> /dev/null"
        "exec": "$HOME/.config/waybar/scripts/run-ti-script.sh"
    }

.. code-block:: sh

    $ cat $HOME/.config/waybar/scripts/run-ti-script.sh

    #!/bin/env sh
    # vim: autoindent smartindent expandtab smarttab tabstop=2 softtabstop=2 shiftwidth=2 :

    cleanup () {
      [[ -n $PIDP ]] && kill -TERM $PIDP
    }

    trap cleanup EXIT
    python -u -OO ${HOME}/.config/waybar/scripts/tiling-indicator.py 2>>$HOME/logs/sway-waybar-ws.log &
    PIDP=$!
    wait $PIDP


Polybar:
========

.. code-block:: conf

    [module/layout]
    type = custom/script
    exec = PYTHONPATH=${XDG_CONFIG_HOME}/i3 python -u -m scripts.tiling-indicator.py 2> /dev/null
    interval = 0
    format = "<label>"
    tail = true
    label-font = 6


github :: https://github.com/iziGor
year :: 2021

"""

import i3ipc

i3 = i3ipc.Connection()
last = ''

# Font Awesome 5 Free:style=Solid

# layouts = { "tabbed":  ("61bbf6", "\uf24d")
          # , "stacked": ("00AA00", "\uf5fd")
          # , "splitv":  ("82B8DF", "\uf103")
          # , "splith":  ("CF4F88", "\uf101")
          # }

layouts = { "tabbed":  ("61bbf6", "\uf24d")
          , "stacked": ("00AA00", "\uf5fd")
          , "splitv":  ("82B8DF", "\u2b9f")
          , "splith":  ("CF4F88", "\u2b9e")
          }

# Material Icons

# layouts = {"tabbed":"\ue8d8", "stacked":"\ue3c7", "splitv":"\ue947", "splith":"\ue949"}


def on_event(wm, _):
    global last
    layout = last
    try:
        layout = wm.get_tree().find_focused().parent.layout
    except AttributeError:
        # fullscreen apps may not be focused
        pass
    if  not layout == last:
        ## polybar format output
        # print("%{{F#{}}}{}%{{F-}}".format(*layouts.get(layout, ("888800", "?"))))

        ## waybar format output
        # print("<span color='#{}'>{}</span>".format(*layouts.get(layout, ("888800", "?"))))
        print("{{\"text\":\"<span color='#{}'>{}</span>\", \"tooltip\":\" {} \"}}".format(
            *layouts.get(layout, ("888800", "?")), layout))
    last = layout


# Subscribe to events
i3.on("window::focus", on_event)
i3.on("binding", on_event)

# Show indicator right after launch
on_event( i3, None )

# Start the main loop and wait for events to come in.
i3.main()
