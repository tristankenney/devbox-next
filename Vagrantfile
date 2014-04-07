# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = "devbox.luciditysoftware.com.au"
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network :forwarded_port, host: 8080, guest: 80
  config.vm.network :forwarded_port, host: 8081, guest: 81
  config.vm.synced_folder "/workspace", "/workspace"
  config.vm.synced_folder "/srv/sites-enabled", "/srv/sites-enabled"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
    vb.customize ["modifyvm", :id, "--nestedpaging", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision :shell, :path => "bootstrap.sh"


  # Bootstrap Puppet by updating guest packages and installing the required
  # Puppet modules using libraian-puppet
  #
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path    = "puppet/manifests"
    puppet.manifest_file     = "bootstrap.pp"
    puppet.hiera_config_path = "puppet/hiera.yaml"
    puppet.options = "--verbose --debug"
  end

  # Provision the box according to the main provision manifest
  #
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path    = "puppet/manifests"
    puppet.module_path       = "puppet/modules"
    puppet.manifest_file     = "provision.pp"
    puppet.hiera_config_path = "puppet/hiera.yaml"
    puppet.options = "--verbose --debug"
  end
end
