#!/bin/bash

file="/var/log/apache2/access.log"

pageCount() {

    # Extract only the requested page from Apache logs (field 7)
    # Sort them alphabetically
    # Count occurrences with uniq -c
    # Sort numerically by count
    cat "$file" \
        | awk '{print $7}' \
        | sort \
        | uniq -c \
        | sort -n
}

pageCount
