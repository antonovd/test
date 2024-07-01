FROM        alpine:latest

ARG         OPENSSH_VERSION=${OPENSSH_VERSION:-9.7_p1-r3}
ENV         OPENSSH_VERSION=${OPENSSH_VERSION} \
            ROOT_PASSWORD=root \
            KEYPAIR_LOGIN=false

ADD         entrypoint.sh /
RUN         apk add --upgrade --no-cache openssh=${OPENSSH_VERSION} ffmpeg \
            && chmod +x /entrypoint.sh \
            && mkdir -p /root/.ssh \
            && rm -rf /var/cache/apk/* /tmp/*

EXPOSE      22
VOLUME      ["/etc/ssh"]
ENTRYPOINT  ["/entrypoint.sh"]