#!/bin/bash

mkdir "$data_directory"

# Get the links for all files in the latest gencode release
lynx -listonly -dump "$reference_top_url" | awk '/^[ ]*[1-9][0-9]*\./{sub("^ [^.]*.[ ]*","",$0); print;}'| sort -u > "$links_file"

# Download all gzipped files associated with links. Other files are unnecessary
cat "$links_file" | while read link
do
    if echo "$link" | grep ".gz" ; then
        echo "Downloading $link"
        wget "$link" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue
    fi
done