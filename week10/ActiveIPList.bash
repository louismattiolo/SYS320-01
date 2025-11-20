#!/bin/bash

# Usage: bash ActiveIPList.bash 10.0.17
if [ $# -ne 1 ]; then
    echo "Usage: ActiveIPList.bash <Prefix>"
    exit 1
fi

# Prefix is the first input taken
prefix=$1

# Verify input length (at least 5 characters)
if [ ${#prefix} -lt 5 ]; then
    printf "Prefix length is too short\nPrefix example: 10.0.17\n"
    exit 1
fi

# Loop through the /24 and show only active IPs
for i in {1..254}
do
    ip="$prefix.$i"

    # -c 1 = send 1 packet, -W 1 = 1 second timeout
    if ping -c 1 -W 1 "$ip" &> /dev/null; then
        echo "$ip"
    fi
done

