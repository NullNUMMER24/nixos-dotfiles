# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "nixbox/nixos"
  config.vm.provision "file", source: "configuration.nix", destination: "/home/vagrant/configuration.nix"
end
