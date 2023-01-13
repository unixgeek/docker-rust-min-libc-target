FROM rust:1.66-slim-bullseye as builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates build-essential bison flex texinfo unzip help2man gawk libtool-bin libncurses-dev \
    && groupadd -r rust -g 2000 && useradd -m -r -g rust -u 2000 rust

USER rust
WORKDIR /home/rust

RUN curl http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.25.0.tar.xz | tar -xJf - \
    && cd crosstool-ng-1.25.0 \
    && ./configure --prefix=/home/rust/ct-ng \
    && make \
    && make install \
    && cd .. \
    && /home/rust/ct-ng/bin/ct-ng x86_64-ubuntu14.04-linux-gnu \
    && sed -i'' 's/CT_ZLIB_VERSION="1.2.12"/CT_ZLIB_VERSION="1.2.13"/' .config \
    && /home/rust/ct-ng/bin/ct-ng build \
    && chmod u+w  /home/rust/x-tools/x86_64-ubuntu14.04-linux-gnu \
    && chmod u+w  /home/rust/x-tools/x86_64-ubuntu14.04-linux-gnu/*
ENV PATH /home/rust/x-tools/x86_64-ubuntu14.04-linux-gnu/bin:$PATH

RUN curl https://www.openssl.org/source/openssl-3.0.7.tar.gz | tar -xzf - \
    && cd openssl-3.0.7  \
    && ./config --prefix=/home/rust/x-tools/x86_64-ubuntu14.04-linux-gnu \
    && make CC=x86_64-ubuntu14.04-linux-gnu-cc \
    && make install_sw

ENV OPENSSL_DIR /home/rust/x-tools/x86_64-ubuntu14.04-linux-gnu

RUN mkdir /home/rust/.cargo \
    && echo "[target.x86_64-unknown-linux-gnu]" > /home/rust/.cargo/config \
    && echo "linker = 'x86_64-ubuntu14.04-linux-gnu-cc'" >> /home/rust/.cargo/config
# Only needed because .cargo/config gets ignored with docker container run, but why does it get ignored?
ENV RUSTFLAGS '-C linker=x86_64-ubuntu14.04-linux-gnu-cc'

# entry point / cmd
# what is the src directory for the freebsd build?
# you forgot the cargo config and you deleted the vm
# -w option on other images?