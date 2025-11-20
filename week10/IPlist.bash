#!/bin/bash

# List all the IPs in the given network prefix
# /24 only

# Usage: bash IPList.bash 10.0.17
if [ $# -ne 1 ]; then
    echo "Usage: IPList.bash <Prefix>"
    exit 1
fi

# Prefix is the first input taken
prefix=$1

# Verify input length (must be at least 5 characters)
if [ ${#prefix} -lt 5 ]; then
    printf "Prefix length is too short\nPrefix example: 10.0.17\n"
    exit 1
fi

# Loop through 1–254
for i in {1..254}
do
    echo "$prefix.$i"
done

