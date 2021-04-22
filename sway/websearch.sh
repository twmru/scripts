#! /bin/sh
ENGINE=$(echo "duckduckgo"$'\n'"searx"$'\n'"searx_refresh"$'\n'"youtubev"$'\n'"$(s -l)" | bemenu -p "Search engine:")

searx_instances() {
	cat ~/.local/instances.json | jq -r '.instances | to_entries | map(select(.value.tls.grade >= "A")) | sort_by(.value.http.grade) | .[].key'
}

searx_search() {
	SEARX=$(searx_instances | bemenu -p "searx instance:") && \
	QUERY="search?q=$(echo | bemenu -p "$SEARX:")" && \
	firefox-nightly "$SEARX$QUERY" & disown
}

youtube_search() {
  QUERY=$(echo "" | bemenu -p "Youtube search:") && \
  VIDEOS=$(youtube-dl -j "ytsearch5:$QUERY") && \
  TITLE=$(echo $VIDEOS | jq '.title' | bemenu -p "title" -l 5) && \
	RESULT=$(echo $VIDEOS | jq "select(.title == $TITLE) | .webpage_url" -r) && \
	echo $RESULT | wl-copy
	ytmpv
}

case "$ENGINE" in
	"")
		exit 0
		;;

	searx)
		searx_search
		;;

	searx_refresh)
		curl https://searx.space/data/instances.json > ~/.local/instances.json
		searx_search
		;;

	youtubev)
		youtube_search
		;;

	*)
		s -p $ENGINE $(echo | bemenu -p "$ENGINE:")
		;;
esac
