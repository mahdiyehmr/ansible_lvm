Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "private_network", ip: "192.168.56.220"

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.ssh/mykey.pub"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.cpus = 4
    vb.memory = "8192"
  end

  config.vm.disk :disk, size: "5GB", primary: false, name: "disk1"
  
  config.vm.disk :disk, size: "10GB", primary: false, name: "disk2"
  config.vm.disk :disk, size: "10GB", primary: false, name: "disk3"
  config.vm.disk :disk, size: "10GB", primary: false, name: "disk4"

  config.vm.provision "shell", inline: <<-SHELL
    cat /home/vagrant/.ssh/mykey.pub >> /home/vagrant/.ssh/authorized_keys
    apt-get update
  SHELL
end
