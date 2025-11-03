#!/bin/sh
TIMEOUT=$1
if [ "$TIMEOUT" == '' ]; then
  TIMEOUT='90' # Use default
fi
echo "Running \`nmcli --wait "$TIMEOUT" dev wifi connect '(your wifi name)'\`,"
echo 'where "--wait" specifies the timeout in seconds.'
echo '`sudo wifi.sh` defaults to 90. Can override default like so:'
echo '`sudo wifi.sh 200`.'
echo
echo 'Reminder that you can connect your local workstation to wifi and still'
echo 'be connected to the DevNet server for Mattermost, git, etc.'
nmcli --wait "$TIMEOUT" dev wifi connect 'your-wifi-here'