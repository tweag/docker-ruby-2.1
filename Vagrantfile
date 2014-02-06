Vagrant.configure('2') do |config|
  config.vm.box = "centos-6.5"
  config.vm.box_url =
    "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.1/centos65-x86_64-20131205.box"

  config.vm.provider "virtualbox" do |vbox|
    vbox.memory = 2048

    vbox.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
  end

  config.vm.provision :shell, inline: <<-SCRIPT
    set -ex
    yum install docker-io -y
    service docker start
  SCRIPT
end
