# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "devbox.luciditysoftware.com.au"
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network :forwarded_port, host: 8080, guest: 80
  config.vm.network :forwarded_port, host: 8081, guest: 81
  config.vm.network :forwarded_port, host: 33306, guest: 3306
  config.vm.network :forwarded_port, host: 9200, guest: 9200
  config.vm.network :forwarded_port, host: 4444, guest: 4444
  config.vm.network :forwarded_port, host: 5900, guest: 5900

  config.vm.synced_folder "/workspace", "/workspace", type: "nfs"
  config.vm.synced_folder "/srv/sites-enabled", "/srv/sites-enabled"

  config.ssh.password = "vagrant"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "4"]
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
    vb.customize ["modifyvm", :id, "--nestedpaging", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    #vb.gui = true
  end

  Vagrant::Config.run do |config|
    config.vbguest.auto_update = true
    config.vbguest.no_remote = false
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
    #puppet.options = "--verbose --debug"
  end

  #config.vm.provision :shell, :path => "phpfpm.sh"
end
