#!/bin/sh

# Add Third-Party Repositories
sources=$(find /etc/apt/sources.list.d | xargs grep 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | cut -d ":" -f1 | uniq)

if [ -z $sources ]
  then
    echo "Adding 10gen repository."
    sudo sh -c "echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' >> /etc/apt/sources.list.d/downloads-distro.mongodb.org.list"
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
fi

# Update apt-get
echo "Updating package list."
sudo apt-get update 2>/dev/null 1>/dev/null

# Install build-essential
dpkg -L build-essential 2>/dev/null 1>/dev/null
if [ $? -eq 1 ]
  then
    echo "Installing build-essential"
    sudo apt-get -y install build-essential
fi

# Install libssl-dev
dpkg -L libssl-dev 2>/dev/null 1>/dev/null
if [ $? -eq 1 ]
  then
    echo "Installing libssl-dev"
    sudo apt-get -y install libssl-dev
fi

# Install openssh-server
dpkg -L openssh-server 2>/dev/null 1>/dev/null
if [ $? -eq 1 ]
  then
    echo "Installing openssh-server"
    sudo apt-get -y install openssh-server
fi

# Install pkg-config
dpkg -L pkg-config 2>/dev/null 1>/dev/null
if [ $? -eq 1 ]
  then
    echo "Installing pkg-config"
    sudo apt-get -y install pkg-config
fi

# Install curl
dpkg -L curl 2>/dev/null 1>/dev/null
if [ $? -eq 1 ]
  then
    echo "Installing curl"
    sudo apt-get -y install curl
fi

# Install git-core
dpkg -L git-core 2>/dev/null 1>/dev/null
if [ $? -eq 1 ]
  then
    echo "Installing git-core"
    sudo apt-get -y install git-core
fi

# Install mongoDB
dpkg -L mongodb-10gen 2>/dev/null 1>/dev/null
if [ $? -eq 1 ]
  then
    echo "Installing mongodb-10gen"
    sudo apt-get -y install mongodb-10gen
fi

# Install node.js
node_version=$(node --version)
if [ $node_version != "v0.6.1" ]
  then
    echo 'Installing node.js.'
    cd /tmp
    curl -O http://nodejs.org/dist/v0.6.1/node-v0.6.1.tar.gz
    tar -xzf node-v0.6.1.tar.gz
    cd node-v0.6.1
    ./configure
    make -j2
    sudo make install
    rm -rf node-v0.6.1
fi

# Install npm
echo "Installing npm."
curl http://npmjs.org/install.sh | sudo sh
