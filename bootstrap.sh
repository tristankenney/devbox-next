#!/bin/bash

apt-get install --yes lsb-release
DISTRIB_CODENAME=$(lsb_release --codename --short)
DEB="puppetlabs-release-${DISTRIB_CODENAME}.deb"
DEB_PROVIDES="/etc/apt/sources.list.d/puppetlabs.list" # Assume that this file's existence means we have the Puppet Labs repo added

if [ ! -e $DEB_PROVIDES ]
then
    # Print statement useful for debugging, but automated runs of this will interpret any output as an error
    # print "Could not find $DEB_PROVIDES - fetching and installing $DEB"
    wget -q http://apt.puppetlabs.com/$DEB
    sudo dpkg -i $DEB
fi
sudo apt-get update
sudo apt-get install --yes puppet

#set timezone
sudo locale-gen en_AU.UTF-8
echo "Australia/Melbourne" | sudo tee /etc/timezone && sudo dpkg-reconfigure --frontend noninteractive tzdata

# UseDNS no to prevent slow DNS lookups on SSH connection
if grep --quiet 'UseDNS no' /etc/ssh/sshd_config
then
    echo 'DNS patched'
else
    sudo bash -c "echo 'UseDNS no' >> /etc/ssh/sshd_config"
fi