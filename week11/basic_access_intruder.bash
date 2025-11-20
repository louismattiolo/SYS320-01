#!/bin/bash

# basic_access_intruder.bash
# Access the webpage 20 times in a row

for i in {1..20}
do
    echo "Attempt $i"
    curl http://10.0.17.10
    echo ""   # just adds a blank line for readability
done
