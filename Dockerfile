FROM rust

RUN set -ex \
    && apt-get clean \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends git apt-utils apt-transport-https ca-certificates nano

ADD nym nym
WORKDIR nym

RUN cargo build --release

CMD ["target/release/nym-mixnode"]
