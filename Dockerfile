FROM multiarch/alpine:armhf-v3.5
LABEL maintainer "Klud <pierre.ugazm@gmail.com>"
ADD binaries /usr/bin/
COPY entrypoint /
RUN adduser -D -S -h /home/gitlab-runner gitlab-runner && \
    apk add --no-cache \
    dumb-init=1.2.0-r0 \
    bash \
    git \
    ca-certificates \
    openssl \
    wget && \
    chmod +x /usr/bin/gitlab-ci-multi-runner && \
    ln -s /usr/bin/gitlab-ci-multi-runner /usr/bin/gitlab-runner && \
    chmod +x /usr/bin/docker-machine && \
    mkdir -p /etc/gitlab-runner/certs && \
    chmod -R 700 /etc/gitlab-runner && \
    chmod +x /entrypoint
VOLUME ["/etc/gitlab-runner", "/home/gitlab-runner"]
ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]