FROM rust

RUN set -ex \
    && apt-get clean \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends git apt-utils apt-transport-https ca-certificates nano

ADD nym nym
WORKDIR nym

RUN chmod +x /nym/scripts/generate_changelog.sh
RUN chmod +x /nym/scripts/run_local_network.sh
RUN cargo build --release

CMD ["target/release/nym-mixnode"]
# CMD ["target/release/nym-client"]
# CMD ["target/release/nym-sfw-provider"]
# CMD ["target/release/nym-validator"]
