# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  #config.vm.box = "puppetlabs-centos-6.5"
  #config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"
  #config.vm.box = "ubuntu/trusty64"
  config.vm.box = "chef/centos-7.0"

  config.vm.synced_folder ".", "/etc/puppet/modules/vim"

  config.vm.provision "shell", path: "provision.sh"

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "tests"
    puppet.manifest_file = "init.pp"
  end

end
