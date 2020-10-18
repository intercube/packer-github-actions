FROM hashicorp/packer:light@sha256:5ebe2fff60ee439d251f2bcbbb71efef6918439dfd04415fc1ab5bd5a212c591

RUN DEBIAN_FRONTEND=noninteractive apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
      ansible

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
