#! /bin/sh
ENGINE=$(echo "duckduckgo"$'\n'"$(s -l)" | bemenu -p "Search engine:") && s -p $ENGINE $(echo | bemenu -p "$ENGINE:")
