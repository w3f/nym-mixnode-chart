FROM rust:1.42.0
ENV KUBECTL_VERSION=v1.17.3
ENV CLOUD_SDK_VERSION=283.0.0

RUN set -ex \
    && apt-get clean \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends git apt-utils apt-transport-https ca-certificates

RUN wget https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  chmod a+x ./kubectl && \
  mv ./kubectl /usr/local/bin

RUN git clone https://github.com/nymtech/nym.git
WORKDIR nym

RUN cargo build --release
RUN target/release/nym-mixnode init --id w3f --host 0.0.0.0 ----announce-host 0.0.0.0 --layer 3 --port 8000
EXPOSE 8000

ENTRYPOINT target/release/nym-mixnode run --id w3f --port 8000
