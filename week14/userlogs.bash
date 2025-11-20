#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser" 
}

function getFailedLogins(){
 logline=$(cat "$authfile" | grep "Failed password")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
 echo "$dateAndUser"
}

# Sending logins as email - Do not forget to change email address
# to your own email address
echo "To: louis.mattiolo@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp louis.mattiolo@mymail.champlain.edu

# Sending failed logins as email
echo "To: louis.mattiolo@mymail.champlain.edu" > emailform_failed.txt
echo "Subject: Failed Logins" >> emailform_failed.txt
getFailedLogins >> emailform_failed.txt
cat emailform_failed.txt | ssmtp louis.mattiolo@mymail.champlain.edu
