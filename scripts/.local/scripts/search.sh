#!/usr/bin/env sh

# This script is used to search for a package in the dnf repo
# Dependencies: curl, gum, pup, wl-clipboard, fzf

# Usage: search.sh <package name>



# Print help message
print_help() {
    echo "Usage: search.sh <package name>"
}

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    print_help
    exit 1
fi

search_query=$1

if [ -z "$search_query" ]; then
	search_query=$(gum input --placeholder "Enter package name")
fi

if [ -z "$search_query" ]; then
    echo "No package name provided"
    exit 1
fi

search_query=$(echo "$search_query" | sed 's/ /+/g')
echo "Searching for $search_query"

url="https://packages.fedoraproject.org/search?query=$search_query"

if [ "$2" != "-a" ];then
	url="$url&releases=Fedora+$(grep "VERSION_ID" /etc/os-release | cut -f2 -d=)"
fi

echo "$url"


list=$(gum spin --title "Fetching packages..." -- \
	curl -s "$url" \
		| pup '.new-block' text{} \
		| grep -v '^\s*$' \
		| sed 'N;s/\n - /\t/')

package=$(echo "$list" | fzf) 
echo "$package"
echo "$package" | cut -f1 | tr -d '\n' | wl-copy
