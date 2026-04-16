Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.define "k3s" do |k3s|
    k3s.vm.box = "debian/bullseye64"
    k3s.vm.network "forwarded_port", guest: 22, host: 2222, host_ip: "0.0.0.0", id: "ssh", auto_correct: true
    k3s.vm.network "private_network", type: "dhcp"
    k3s.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
      vb.name = "k3s-node-tp"
    end
  end

  config.vm.define "monitoring" do |monitoring|
    monitoring.vm.box = "debian/bullseye64"
    monitoring.vm.network "forwarded_port", guest: 22, host: 2200, host_ip: "0.0.0.0", id: "ssh", auto_correct: true
    monitoring.vm.network "private_network", type: "dhcp"
    monitoring.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.name = "monitoring-node-tp"
    end
  end
end
