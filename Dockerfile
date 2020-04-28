FROM node:13-alpine

RUN apk add --no-cache \
      # yarn and npm need git to grab stuff
      git \
      # pre-built binaries from npm are likely built for more typical linux distros
      # so add the compatibility layer for that
      libc6-compat

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
