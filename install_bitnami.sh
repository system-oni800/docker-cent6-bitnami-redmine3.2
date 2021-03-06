#!/usr/bin/expect

set timeout 550
spawn /root/bitnami-redmine-linux-x64.run
expect "Please choose an option"
send -- "1\r"
expect "Subversion"
send -- "n\n"
expect "PhpMyAdmin"
send -- "\r"
expect "Git "
send -- "n\n"
expect "Is the selection above correct?"
send -- "\r"
expect "Select a folder"
send -- "/opt/redmine/\r"
expect "Your real name"
send -- "admin\n"
expect "Email Address"
send -- "\n"
expect "Login"
send -- "rmadmin\n"
expect "Password"
send -- "_SET_PASSWORD_\n"
expect "Please confirm your password"
send -- "_SET_PASSWORD_\n"
expect "Please choose an option"
send -- "9\n"
expect "Do you want to configure mail support?"
send -- "n\n"
expect "Do you want to continue?"
send -- "Y\n"
expect "Launch Redmine application."
send -- "Y\n"
expect "Press"
send -- "\n"
interact
exit
