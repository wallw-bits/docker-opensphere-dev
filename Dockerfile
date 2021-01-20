FROM node:lts-alpine3.12

RUN apk add --no-cache \
      # yarn and npm need git to grab stuff
      git \
      # pre-built binaries from npm are likely built for more typical linux distros
      # so add the compatibility layer for that
      libc6-compat \
      openjdk11 \
      # these are a little redundant, should probably just use sed
      perl \
      python3 \
      sed

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh \
    && ln -s /usr/bin/python3 /usr/bin/python

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
