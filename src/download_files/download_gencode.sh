#!/bin/bash

###########################Parameters###########################
#url
url="ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/latest_release"
#out directory
out_dir=./files/
links_file="$out_dir""links.txt"
###########################End Parameters###########################



# Get the links for all files in the latest gencode release
lynx -listonly -dump "$url" | awk '/^[ ]*[1-9][0-9]*\./{sub("^ [^.]*.[ ]*","",$0); print;}'| sort -u > "$links_file"

# Download all gzipped files associated with links. Other files are unnecessary
cat "$links_file" | while read link
do
    if echo "$link" | grep ".gz" ; then
        echo "Downloading $link"
        #link_file_name="$(basename -- $link)"
        wget "$link" --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 --continue
        # if [ $? = 0 ]; then break; fi; # check return value, break if successful (0)
        #     sleep 1s;
        # fi
    fi
done