#!/usr/bin/env sh

# Quote of the day using bing search engine
# Dependency: curl, pup

curl -Ls 'https://bing.com/search?q=quote+of+the+day' | pup '#bt_qotdText' text{}
