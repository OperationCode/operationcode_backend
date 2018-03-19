# Virtual Machine

A virtual machine is defined as a computer file, typically called an image, that behaves like an actual computer.

## Create AWS VM
(Using Ubuntu 16.04 on AWS)
Make sure to open these ports in your security group
- Port 22
- Port 3000
When the VM spins up, SSH into it.

##
(from your VM)
Fork https://github.com/operationcode/operationcode_backend

```bash
git clone https://github.com/[YOUR-GITHUB-NAME]/operationcode_backend.git

cd operationcode_backend

git remote add upstream https://github.com/OperationCode/operationcode_backend.git

sudo apt-get install make
```

## Install Docker
```bash
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce
```

## Install Docker Compose

```bash
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Setting up the Dev Environment
```bash
sudo make setup
```

(if you want to try running the tests, run this command)

```bash
sudo make test
```

Now navigate to http://<vm_public_ip>:3000 and you should see the "You're running on Rails" page!
