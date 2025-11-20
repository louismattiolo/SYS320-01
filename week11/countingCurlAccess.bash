#!/bin/bash

file="/var/log/apache2/access.log"

countingCurlAccess() {

    # Field 1 = IP address
    # Field 12 = (usually "curl/x.x.x")
    # uniq -c counts how many times each IP shows up
    grep "curl" "$file" \
        | awk '{print $1, $12}' \
        | uniq -c
}

countingCurlAccess
