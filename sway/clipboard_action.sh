#! /bin/sh
export INPUT="$(wl-paste)";
export CLIPBOARD_ACTION_DIR="$(echo "" | bemenu -p "Action at> ~/")";
mkdir -p $CLIPBOARD_ACTION_DIR;
pushd $CLIPBOARD_ACTION_DIR;
$SHELL -c "$(awk 'gsub("%s", ENVIRON["INPUT"])' ~/.local/clipboard_commands.txt | bemenu -l 5 -p "Action>")" & disown;
popd;
export INPUT;
