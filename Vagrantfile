Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "8192"
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y curl build-essential bison flex texinfo unzip help2man gawk libtool-bin libncurses-dev
  # curl ? http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.25.0.tar.xz | tar - blah blah
  #  ./configure --prefix=/home/vagrant/ct-ng # is wget already on here?
  # make
  # make install
  # export PATH=/home/vagrant/ct-ng/bin:$PATH
  # ct-ng x86_64-ubuntu14.04-linux-gnu
  # mkdir src (remove later)
  # curl -Of  https://www.zlib.net/fossils/zlib-1.2.12.tar.gz -> to src directory instead put CT_ZLIB_VERSION="1.2.13" in config?
  # ct-ng build
  # chmod u+w  x-tools/x86_64-ubuntu14.04-linux-gnu
  # chmod u+w  x-tools/x86_64-ubuntu14.04-linux-gnu/*
  # curl -Of https://www.openssl.org/source/openssl-3.0.7.tar.gz
  # export PATH=/home/vagrant/x-tools/x86_64-ubuntu14.04-linux-gnu/bin:$PATH
  # ./config --prefix=/home/vagrant/x-tools/x86_64-ubuntu14.04-linux-gnu # how to disable man pages?
  # make CC=x86_64-ubuntu14.04-linux-gnu-cc
  # make install ? install_sw?
  # SHELL
end
