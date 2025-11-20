#!/bin/bash

ip addr | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}'  | cut -d/ -f1

# grep inet finds IPv4 lines then grep v removes the localhost addr and awk picks 
# the 2nd field (the ipaddress) and cut -d/ -f1 splits the slash and keeps the IP part
