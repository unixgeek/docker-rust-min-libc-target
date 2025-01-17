FROM debian:bookworm-20250113-slim AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates build-essential bison flex texinfo unzip help2man gawk libtool-bin libncurses-dev \
    && groupadd rust -g 2000 && useradd -m -g rust -u 2000 rust

USER rust
WORKDIR /home/rust
ENV PATH /home/rust/x-tools/x86_64-ubuntu14.04-linux-gnu/bin:$PATH

RUN curl http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.26.0.tar.xz | tar -xJf - \
    && cd crosstool-ng-1.26.0 \
    && ./configure --prefix=/home/rust/ct-ng \
    && make \
    && make install \
    && cd .. \
    && /home/rust/ct-ng/bin/ct-ng x86_64-ubuntu14.04-linux-gnu \
    && /home/rust/ct-ng/bin/ct-ng build \
    && chmod u+w  /home/rust/x-tools/x86_64-ubuntu14.04-linux-gnu \
    && chmod u+w  /home/rust/x-tools/x86_64-ubuntu14.04-linux-gnu/*  \
    && curl --location https://www.openssl.org/source/old/1.0.1/openssl-1.0.1u.tar.gz | tar -xzf - \
    && cd openssl-1.0.1u \
    && ./config -fPIC no-shared --prefix=/home/rust/x-tools/x86_64-ubuntu14.04-linux-gnu \
    && make CC=x86_64-ubuntu14.04-linux-gnu-cc \
    && make install_sw

FROM rust:1.84.0-slim-bookworm

COPY --from=builder /home/rust/x-tools /usr/local/x-tools

RUN groupadd rust -g 2000 \
    && useradd -m -g rust -u 2000 rust \
    && echo "[target.x86_64-unknown-linux-gnu]" > /usr/local/cargo/config.toml \
    && echo "linker = 'x86_64-ubuntu14.04-linux-gnu-cc'" >> /usr/local/cargo/config.toml \
    && apt-get update \
    && apt-get install -y --no-install-recommends make libfindbin-libs-perl

ENV PATH /usr/local/x-tools/x86_64-ubuntu14.04-linux-gnu/bin:${PATH}
ENV OPENSSL_DIR /usr/local/x-tools/x86_64-ubuntu14.04-linux-gnu
USER rust
WORKDIR /src

ENTRYPOINT ["cargo"]
