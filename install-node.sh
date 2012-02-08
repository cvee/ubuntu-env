#!/bin/sh

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

# Install node.js
node_version=$(node --version 2>/dev/null)
if [ "$node_version" != "v0.6.10" ]
  then
    echo 'Installing node.js.'
    curl -L http://nodejs.org/dist/v0.6.10/node-v0.6.10.tar.gz | tar -C /tmp -xzf -
    cd /tmp/node-v0.6.10
    ./configure
    make -j2 && sudo make install
    cd ~/
    rm -rf /tmp/node-v0.6.10
fi

# Install npm
# As of node.js 0.6.3, npm is included in packages/installers and installed on
# make install so the following section is no longer necessary.
#echo "Installing npm."
#curl http://npmjs.org/install.sh | sudo sh

# Create a Dedicated User Account
# To avoid the security concerns caused by running applications as root,
# create a user responsible for running node apps.
sudo useradd --create-home --user-group --shell /bin/bash node
sudo su -c "ssh-keygen -b 4096 -t rsa -N '' -f ~/.ssh/id_rsa" -l node
