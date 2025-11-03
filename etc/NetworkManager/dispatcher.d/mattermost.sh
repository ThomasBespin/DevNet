#!/bin/sh

# Again, very likely, your interface name starts with "enp".
# The env vars below are populated by Network Manager's dispatcher.
if [ "$NM_DISPATCHER_ACTION" = 'up'  ] && [ "$DEVICE_IP_IFACE" = 'your-interface-here' ]; then
  systemctl start mattermost
fi
