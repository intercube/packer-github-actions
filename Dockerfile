FROM hashicorp/packer:light@sha256:9de774eebc434af0f04f6d0a7e3bed7b25549b983e1d59b803b461be417fe277

ENV ANSIBLE_VERSION 2.9.13
ENV ANSIBLE_LINT 3.5.1
ENV DOCKER_PY_VERSION 1.10.6

RUN apk add --update python py-pip openssl ca-certificates bash git sudo zip \
    && apk --update add --virtual build-dependencies python-dev libffi-dev openssl-dev build-base \
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
