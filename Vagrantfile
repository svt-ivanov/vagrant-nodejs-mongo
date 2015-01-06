Vagrant.configure("2") do |config|
    
    # Specify the base box
    config.vm.box = "ubuntu/trusty64"
    
    # Setup port forwarding
    config.vm.network :forwarded_port, guest: 1337, host: 8000, auto_correct: true

    # Setup synced folder
    config.vm.synced_folder "./", "/home/vagrant/test", create: true

    # VM specific configs
    config.vm.provider "virtualbox" do |v|
        v.name = "Node Test Box"
        v.customize ["modifyvm", :id, "--memory", "1024"]
    end

    # Shell provisioning
    config.vm.provision "shell" do |s|
        s.path = "provision.sh"
    end
end