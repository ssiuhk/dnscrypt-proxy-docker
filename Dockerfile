FROM alpine:latest

ARG VERSION

ENV DNSCRYPT_PORT  53

RUN apk add --no-cache dnscrypt-proxy drill

USER dnscrypt

EXPOSE $DNSCRYPT_PORT/tcp $DNSCRYPT_PORT/udp

HEALTHCHECK --interval=5s --timeout=3s --start-period=10s \
    CMD drill -p $DNSCRYPT_PORT www.google.com @127.0.0.1 || exit 1

CMD /usr/bin/dnscrypt-proxy \
    -config /etc/dnscrypt-proxy/dnscrypt-proxy.toml
