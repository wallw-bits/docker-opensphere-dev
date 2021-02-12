#!/bin/sh

# Add local user
# Use the LOCAL_USER_ID passed in at runtime
# This ensures the container user has permissions to write to the mounted volumes

echo "Adding user to match $LOCAL_USER_ID for proper volume permissions"

adduser \
  --disabled-password \
  --gecos "" \
  --group \
  --home /home/dev-user \
  --shell /bin/bash \
  --system \
  --uid $LOCAL_USER_ID \
  dev-user

cp -R /etc/skel/.profile /etc/skel/.bashrc /etc/skel/.bash_logout /home/dev-user
mkdir /yarn-cache
chown -R dev-user:dev-user /home/dev-user /yarn-cache
su dev-user -c 'yarn config set cache-folder /yarn-cache'
su dev-user -c 'npm config set scripts-prepend-node-path true'
# export chromium as CHROME_BIN so tests pick that change up
echo 'export CHROME_BIN=$(which chromium)' >> /home/dev-user/.bashrc

if [ -z "$*" ]; then
  exec su dev-user
else
  echo "command: $*"
  exec su dev-user --command "$*"
fi
