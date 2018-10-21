FROM alpine:latest
LABEL maintainer="beresnev-dr@yandex.ru"
ARG VERSION=0.2.13
RUN apk update
RUN apk upgrade
RUN apk add bash nano
RUN apk add libevent --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/main/ --allow-untrusted
RUN apk add tor --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/community/ --allow-untrusted
RUN adduser -D -s /bin/false -H obfsproxy && apk add --no-cache --virtual=build-dependencies \
    build-base gmp-dev python-dev && apk add --no-cache python py-pip su-exec \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir obfsproxy==$VERSION \
    && apk del --purge build-dependencies \
    && rm -rf /tmp/*
EXPOSE 9150
RUN rm /var/cache/apk/*
ADD ./torrc /etc/tor/torrc
USER tor
CMD /usr/bin/tor -f /etc/tor/torrc
