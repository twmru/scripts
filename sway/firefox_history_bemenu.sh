#! /bin/sh

# Set profile instead of star
cp ~/.mozilla/firefox/*/places.sqlite /tmp/places.sqlite
TITLE="$(echo "select title from moz_places order by title;" | sqlite3 /tmp/places.sqlite | uniq -u | bemenu -p "history>" -l 10)"
[ $TITLE ] firefox "$(echo "select url from moz_places where title LIKE '$TITLE%' limit 1;" | sqlite3 /tmp/places.sqlite)"
