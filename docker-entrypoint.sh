#!/bin/bash

cmd="$@"

## Execute with current user ID.
if [ ${UID:-0} -ne 0 ] && [ ${GID:-0} -ne 0 ]; then
   echo -e "Executing command: '$cmd' as user ${UID}"
   groupadd -g ${GID} ansible
   useradd -u ${UID} -g ansible ansible
   chown ansible:ansible /home/ansible
   su ansible -c "$cmd"
else
   echo -e "Executing command: $cmd as root"
   $cmd
fi
