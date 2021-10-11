#!/bin/bash
luid=$(grep "^UID_MIN" /etc/login.defs)
groupname="login-local"
groupadd $groupname
localusers=$(awk -F':' -v "limit=${luid##UID_MIN}" '{ if ( $3 >= limit ) print $1 }' /etc/passwd)
for user in $localusers; do
shell=$(getent passwd $user | awk -F: '{print $NF}')
if [[ $shell == "/bin/bash" ]]; then usermod -aG $groupname $user;echo $user; fi;
done