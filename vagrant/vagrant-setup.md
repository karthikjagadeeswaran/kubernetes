# install vagrant binaries

    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install vagrant

# install virtualbox 

    sudo apt-get --fix-broken install virtualbox
    apt-get install linux-generic linux-image-generic linux-headers-generic linux-signed-generic
    sudo dkms autoinstall

    incase of error
    apt-get install --yes linux-headers-5.4.0-90-generic
    sudo dkms autoinstall



