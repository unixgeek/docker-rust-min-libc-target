# Docker Rust Minimum glibc Target ![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/unixgeek2/rust-min-libc) ![Docker Image Version (latest by date)](https://img.shields.io/docker/v/unixgeek2/rust-min-libc)
This Docker image is used to compile Rust targeting a minimum glibc for more portable binaries. It is based on the official
Rust Docker image and uses a toolchain, built using crosstool-ng, that mirrors glibc from Ubuntu 14.04. It also includes OpenSSL.

## Usage
Compile
```shell
docker container run --rm --volume "$(pwd)":/src     \
    --init --tty --user "$(id --user):$(id --group)" \
    unixgeek2/rust-min-libc build --release
```
Check glibc dependencies
```shell
objdump -T BINARY | grep GLIBC | sed 's/.*GLIBC_\([.0-9]*\).*/\1/g' | sort -Vu
```
## Compatability
As a smoke test, a simple Rust binary that uses the [openssl](https://docs.rs/openssl/0.10.62/openssl/) crate was 
compiled two ways: first with the `default` feature set and second with the `vendored` feature. It was then executed on
the following Docker images:
* ubuntu:14.04
* ubuntu:16.04
* ubuntu:18.04
* ubuntu:20.04
* ubuntu:22.04
* debian:buster-slim
* debian:bullseye-slim
* debian:bookworm-slim
* rockylinux:8
* rockylinux:9
* opensuse/tumbleweed:latest
* opensuse/leap:latest

## Docker Hub
[rust-min-libc](https://hub.docker.com/r/unixgeek2/rust-min-libc)

## Credits
* [crosstool-ng](https://crosstool-ng.github.io/)
* [A one-liner I was too lazy to come up with](https://stackoverflow.com/questions/3436008/how-to-determine-version-of-glibc-glibcxx-binary-will-depend-on)
