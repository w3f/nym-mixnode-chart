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
ENV PATH /google-cloud-sdk/bin:$PATH
RUN cd / && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
  tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
  rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
  ln -s /lib /lib64 && \
  gcloud config set core/disable_usage_reporting true && \
  gcloud config set component_manager/disable_update_check true && \
  gcloud config set metrics/environment github_docker_image && \
  gcloud --version

RUN git clone https://github.com/nymtech/nym.git
WORKDIR nym

RUN cargo build --release
RUN mkdir /root/.nym/ && mkdir /root/.nym/mixnodes/ && mkdir /root/.nym/mixnodes/w3f/ && mkdir /root/.nym/mixnodes/w3f/data/ && mkdir /root/.nym/mixnodes/w3f/config/
COPY config/config.toml /root/.nym/mixnodes/w3f/config/config.toml
EXPOSE 8000

ENTRYPOINT target/release/nym-mixnode run --id w3f --host ${INTERNAL_IP} --announce-host ${EXTERNAL_IP}
