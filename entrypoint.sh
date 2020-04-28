#!/bin/sh

# Add local user
# Use the LOCAL_USER_ID passed in at runtime
# This ensures the container user has permissions to write to the mounted volumes

echo "Adding user to match $LOCAL_USER_ID for proper volume permissions"

# Note: this user creation method is to handle high IDs in Alpine Linux
# See https://stackoverflow.com/questions/41807026/cant-add-a-user-with-a-high-uid-in-docker-alpine
echo "user:x:$LOCAL_USER_ID:$LOCAL_USER_ID::/home/user:" >> /etc/passwd
## thanks for http://stackoverflow.com/a/1094354/535203 to compute the creation date
echo "user:!:$(($(date +%s) / 60 / 60 / 24)):0:99999:7:::" >> /etc/shadow
echo "user:x:$LOCAL_USER_ID:" >> /etc/group
mkdir /home/user && chown user: /home/user

export HOME=/home/user
su user -c 'yarn config set cache-folder /yarn-cache'
su user -c 'npm config set scripts-prepend-node-path true'
exec su user "$@"
