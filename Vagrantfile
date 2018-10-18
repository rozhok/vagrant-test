# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define 'apache-blue' do |nodeconfig|
    nodeconfig.vm.box = 'centos/7'
    nodeconfig.vm.hostname = 'apache-blue.box'
    nodeconfig.vm.network :private_network, ip: '192.168.100.101'
    nodeconfig.vm.provision :chef_solo do |chef|
      chef.add_recipe 'apache-blue'
    end

    memory = 256
    nodeconfig.vm.provider :virtualbox do |vb|
      vb.customize [
                       "modifyvm", :id,
                       "--cpuexecutioncap", "50",
                       "--memory", memory.to_s,
                   ]
    end
  end

  config.vm.define 'apache-green' do |nodeconfig|
    nodeconfig.vm.box = 'centos/7'
    nodeconfig.vm.hostname = 'apache-green.box'
    nodeconfig.vm.network :private_network, ip: '192.168.100.102'
    nodeconfig.vm.provision :chef_solo do |chef|
      chef.add_recipe 'apache-green'
    end

    memory = 256
    nodeconfig.vm.provider :virtualbox do |vb|
      vb.customize [
                       "modifyvm", :id,
                       "--cpuexecutioncap", "50",
                       "--memory", memory.to_s,
                   ]
    end
  end

  config.vm.define 'haproxy-lb' do |nodeconfig|
    nodeconfig.vm.box = 'centos/7'
    nodeconfig.vm.hostname = 'haproxy-lb.box'
    nodeconfig.vm.network :private_network, ip: '192.168.100.103'
    nodeconfig.vm.provision :chef_solo do |chef|
      chef.add_recipe 'haproxy-lb'
    end

    memory = 256
    nodeconfig.vm.provider :virtualbox do |vb|
      vb.customize [
                       "modifyvm", :id,
                       "--cpuexecutioncap", "50",
                       "--memory", memory.to_s,
                   ]
    end
  end

end
