## $ docker build --tag caspiandb/debian-asdf-awscli --squash .

ARG DEBIAN_ASDF_TAG=latest
ARG VERSION=latest

ARG BUILDDATE
ARG REVISION


FROM caspiandb/debian-asdf:${DEBIAN_ASDF_TAG}

ARG BUILDDATE
ARG REVISION
ARG VERSION

RUN apt-get -q -y update
RUN apt-get -q -y --no-install-recommends install \
  bzip2 git-lfs gnupg groff-base jq openssh-client procps pv xz-utils

ADD https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem /usr/local/share/ca-certificates/global-bundle.crt

RUN update-ca-certificates

COPY .tool-versions /root/

RUN while read -r plugin _version; do test -d ~/.asdf/plugins/"$plugin" || asdf plugin add "$plugin"; done < .tool-versions
RUN asdf install

RUN asdf list

ADD https://raw.githubusercontent.com/dex4er/tf/main/tf.sh /usr/local/bin/tf
RUN chmod +x /usr/local/bin/tf

RUN tf version

RUN apt-get -q -y autoremove
RUN find /var/cache/apt /var/lib/apt/lists /var/log -type f -delete

LABEL \
  maintainer="CaspianDB <info@caspiandb.com>" \
  org.opencontainers.image.created=${BUILDDATE} \
  org.opencontainers.image.description="Container image with AWS CLI, Infracost and Terraform" \
  org.opencontainers.image.licenses="MIT" \
  org.opencontainers.image.revision=${REVISION} \
  org.opencontainers.image.source=https://github.com/CaspianDB/docker-debian-asdf-terraform \
  org.opencontainers.image.title=debian-asdf-terraform \
  org.opencontainers.image.url=https://github.com/CaspianDB/docker-debian-asdf-terraform \
  org.opencontainers.image.vendor=CaspianDB \
  org.opencontainers.image.version=${VERSION}
