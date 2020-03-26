FROM rust:1.42.0

RUN set -ex \
    && apt-get clean \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends git apt-utils apt-transport-https ca-certificates

RUN git clone https://github.com/nymtech/nym.git
WORKDIR nym

RUN cargo build --release

EXPOSE 8000
CMD ["target/release/nym-mixnode"]
