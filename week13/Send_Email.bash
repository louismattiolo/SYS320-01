#!/bin/bash

echo "To: louis.mattiolo@mymail.champlain.edu" > emailform.txt
echo "Subject: Security Incident" >> emailform.txt
echo "Testing123" >> emailform.txt
cat emailform.txt | ssmtp louis.mattiolo@mymail.champlain.edu
