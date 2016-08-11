#!/bin/bash

# ensure that cloud init is done
echo 'waiting for cloud-init'
while [ ! -f /var/lib/cloud/instance/boot-finished ]; do
  printf '.'
  sleep 1;
done

# set run levels for agent_service
update-rc.d agent_service start 99 2 3 4 5 . stop 20 0 1 6 . || true

# start the service
service agent_service start
