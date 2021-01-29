FROM node:lts-buster-slim

ARG JRE=openjdk-11-jre-headless
# create this directory because the JRE install blows up without it
RUN mkdir -p /usr/share/man/man1 &&\
    apt-get update &&\
    apt-get -y upgrade &&\
    apt-get -y install --no-install-recommends \
      bash \
      chromium \
      firefox-esr \
      git \
      ${JRE} \
      perl \
      python3 \
      sed &&\
    apt-get autoremove &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN deluser node &&\
    chmod +x /usr/local/bin/entrypoint.sh &&\
    ln -s /usr/bin/python3 /usr/bin/python

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
