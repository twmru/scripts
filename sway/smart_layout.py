#! /usr/bin/python
from argparse import ArgumentParser
from typing import List

from i3ipc import Connection, Event, events

# argparse
parser = ArgumentParser(
    description="""
Remembers keyboard layout for each window and restores it
        """
)
parser.add_argument(
    "--kb-id",
    dest="kb_id",
    action="store",
    help="Keyboard's ID got from `swaymsg -t get-input`",
    required=True,
)
parser.add_argument(
    "--max-win-history",
    dest="max_win_history",
    action="store",
    help="Maximum window history.",
    default=15,
    type=int,
)
args = parser.parse_args()


# constants
KB_ID = args.kb_id
MAX_WIN_HISTORY = args.max_win_history


# runtime obj
sway = Connection()

data = {}
window_list: List[int] = []


# helper functions
def get_current_layout_ind(conn: Connection, kb_id: str) -> int:
    inputs = conn.get_inputs()

    res = None
    for input_ in inputs:
        if input_.identifier == kb_id:
            res = input_.xkb_active_layout_index

    if res is None:
        raise ValueError("Your KB_ID is wrong because there is no input with that id")

    return res


def get_current_focused_window_id(conn: Connection) -> int:
    return conn.get_tree().find_focused().id


def get_all_windows_id(conn: Connection) -> set:
    return set(w.id for w in conn.get_tree().leaves())


def get_last_window_id() -> int:
    for window_id in window_list[1:]:
        last_window_id = window_id
        break
    else:
        last_window_id = window_list[0]

    return last_window_id


def change_kbd_layout(conn: Connection, layout_ind: int) -> None:
    conn.command(f"input * xkb_switch_layout {layout_ind}")


# main handler
def handler_on_window_focus(conn: Connection, event: events.WindowEvent):
    current_window_id = event.container.id

    if current_window_id in window_list:
        window_list.remove(current_window_id)
    window_list.insert(0, current_window_id)

    last_window_id = get_last_window_id()

    current_layout_ind = get_current_layout_ind(conn, KB_ID)
    data[last_window_id] = current_layout_ind
    data.setdefault(current_window_id, current_layout_ind)

    change_kbd_layout(conn, data[current_window_id])

    if len(window_list) > MAX_WIN_HISTORY:
        deleting_window_id = window_list.pop(-1)
        del data[deleting_window_id]


def on_startup(conn: Connection):
    """Needs to register first focused window"""

    current_focused_window_id = get_current_focused_window_id(conn)
    current_layout_ind = get_current_layout_ind(conn, KB_ID)
    window_list.append(current_focused_window_id)
    data[current_focused_window_id] = current_layout_ind


def main():
    on_startup(sway)
    sway.on(Event.WINDOW_FOCUS, handler_on_window_focus)
    sway.main()


if __name__ == "__main__":
    main()
