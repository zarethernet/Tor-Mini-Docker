FROM alpine:latest
RUN apk update
RUN apk upgrade
RUN apk add bash nano
RUN apk add libevent --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/main/ --allow-untrusted
RUN apk add tor --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/community/ --allow-untrusted
EXPOSE 9150
RUN rm /var/cache/apk/*
ADD ./torrc /etc/tor/torrc
USER tor
CMD /usr/bin/tor -f /etc/tor/torrc
