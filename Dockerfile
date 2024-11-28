# see https://hub.docker.com/r/hashicorp/packer/tags for all available tags
FROM hashicorp/packer:light@sha256:dd9868ae2b4d4fc658ed32ab9f3277b0a85ad266f8880351f2d51de038e4db5c

ENV ANSIBLE_VERSION 5.1.0
ENV ANSIBLE_LINT 5.3.1
ENV DOCKER_PY_VERSION 1.10.6

RUN apk add --update python3 py-pip openssl ca-certificates bash git sudo zip \
    && apk add --no-cache libressl-dev musl-dev libffi-dev \
    && apk --update add --virtual build-dependencies python3-dev libffi-dev openssl-dev build-base \
    && pip install --no-cache-dir cryptography==2.1.4 \
    && pip install --upgrade pip cffi \
    && echo "Installing Ansible..." \
    && pip install ansible==$ANSIBLE_VERSION ansible-lint==$ANSIBLE_LINT docker-py==$DOCKER_PY_VERSION \
    && pip install --upgrade pycrypto pywinrm  \
    && apk --update add sshpass openssh-client rsync \
    && echo "Removing package list..." \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/*

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
