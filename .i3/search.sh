#!/bin/bash

URL='https://google.com/search?q='
QUERY=$(echo '' | dmenu -p "Search:" -fn "-xos4-terminus-medium-r-*-*-14-*" -b)
if [ -n "$QUERY" ]; then
  xdg-open "${URL}${QUERY}" 2> /dev/null
  exec i3-msg [class="Google-chrome"] focus
fi
