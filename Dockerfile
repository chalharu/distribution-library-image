# Build a minimal distribution container

FROM arm64v8/alpine:3.7

COPY qemu-aarch64-static /usr/bin/qemu-aarch64-static

RUN [ "/usr/bin/qemu-aarch64-static", "/bin/sh", "-c", "apk add --no-cache ca-certificates apache2-utils"]

COPY ./registry/registry /bin/registry
COPY ./registry/config-example.yml /etc/docker/registry/config.yml

VOLUME ["/var/lib/registry"]
EXPOSE 5000

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/etc/docker/registry/config.yml"]
