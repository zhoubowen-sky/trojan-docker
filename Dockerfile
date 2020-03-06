#################
## BUILD STAGE ##
#################
FROM alpine:3.11.3

ENV TROJAN_URL=https://github.com/trojan-gfw/trojan.git

# workspace for app
WORKDIR /opt
ADD . .

# alpine update
RUN apk --no-cache update && apk --no-cache upgrade
# add start-stop-daemon and python runtime
RUN apk --no-cache add monit openrc python

RUN mkdir -p /usr/local/sbin
# build trojan bin file
RUN apk add --no-cache --virtual .build-deps \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
        git \
    && git clone ${TROJAN_URL} \
    && (cd trojan && cmake . && make -j $(nproc) && strip -s trojan \
    && mv trojan /usr/local/sbin) \
    && rm -rf trojan \
    && apk del .build-deps \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

# copy trojan configuration files
RUN cp -rf trojanConsole /usr/local/sbin/ \
    && chmod a+x /usr/local/sbin/trojanConsole

# remove unused files
RUN rm -rf .git .gitignore

# copy monit configuration files
RUN rm -rf /etc/monit.d \
    && cp -rf monit-config/monit.d /etc/ \
    && rm -rf /etc/monitrc \
    && cp -rf monit-config/monitrc /etc/ \
    && chown root:root /etc/monitrc \
    && chmod 0700 /etc/monitrc

# set monit boot up 
RUN rc-update add monit 
