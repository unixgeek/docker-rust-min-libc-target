# Docker Rust Minimum glibc Target
This Docker image is used to compile Rust targeting a minimum glibc for more portable binaries. It is based on the official
Rust Docker image and uses a toolchain that mirrors glibc from Ubuntu 14.04. It also includes OpenSSL.

## Usage
Compile

    docker container run --rm --volume "$(pwd)":/src     \
        --init --tty --user "$(id --user):$(id --group)" \
        unixgeek2/docker-rust-min-libc-target cargo build --release
Check glibc dependencies

    objdump -T BINARY | grep GLIBC | sed 's/.*GLIBC_\([.0-9]*\).*/\1/g' | sort -Vu

## Credits
* [crosstool-ng](https://crosstool-ng.github.io/)
* [A one liner I was too lazy to come up with](https://stackoverflow.com/questions/3436008/how-to-determine-version-of-glibc-glibcxx-binary-will-depend-on)
