#!/bin/bash

echo "*** Provisioning virtual machine..."

echo "*** Updating apt-get..."
sudo apt-get update -y > /dev/null

echo "*** Installling prerequisites..."
sudo apt-get install libexpat1-dev libicu-dev git build-essential curl software-properties-common python-software-properties gcc g++ make -y > /dev/null

echo "*** Installling prerequisites for MongoDB..."
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 > /dev/null
sudo sh -c 'echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" | sudo tee /etc/apt/sources.list.d/mongodb.list' > /dev/null

echo "*** Updating apt-get again..."
sudo apt-get update -y > /dev/null

# Set locales (needed for MongoDB)
cat >> /home/vagrant/.profile << EOF
export LANG="en_US.utf-8"
export LANGUAGE="en_US.utf-8"
export LC_ALL="en_US.utf-8"
EOF
source /home/vagrant/.profile || :

echo "*** Installling MongoDB..."
sudo apt-get install -y mongodb-org # > /dev/null

echo "*** Installling an upstream version of Node and NPM..."
echo 'export PATH=$HOME/local/bin:$PATH' >> /home/vagrant/.bashrc

mkdir /home/vagrant/local
mkdir /home/vagrant/node-latest-install

cd /home/vagrant/node-latest-install
curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
./configure --prefix=/home/vagrant/local
make install

# Install NPM
curl -L https://npmjs.org/install.sh | sh

sudo chown vagrant:vagrant /home/vagrant/local -R
sudo chown vagrant:vagrant /home/vagrant/node-latest-install -R
