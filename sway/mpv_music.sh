#! /bin/sh

X=$(ls ~/media/music | bemenu -l 7)
if [ "" != "$X" ]
then
	mpv --force-window --loop-playlist=inf ~/media/music/$X & disown
fi
