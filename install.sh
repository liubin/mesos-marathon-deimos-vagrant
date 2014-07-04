# Installation of Dependencies

sudo apt-get update

sudo apt-get install -y curl python-setuptools python-pip python-dev python-protobuf

sudo apt-get install -y zookeeperd

echo 1 | sudo dd of=/var/lib/zookeeper/myid


# Installation of Container Manager

sudo apt-get install -y docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker
sudo sed -i '$acomplete -F _docker docker' /etc/bash_completion.d/docker.io

# Installation of Mesosphere

## Installation and Configuration of Mesos 0.19
curl -fL http://downloads.mesosphere.io/master/ubuntu/14.04/mesos_0.19.0~ubuntu14.04%2B1_amd64.deb -o /tmp/mesos.deb
sudo dpkg -i /tmp/mesos.deb

sudo mkdir -p /etc/mesos-master
echo in_memory | sudo dd of=/etc/mesos-master/registry

curl -fL http://downloads.mesosphere.io/master/ubuntu/14.04/mesos-0.19.0_rc2-py2.7-linux-x86_64.egg -o /tmp/mesos.egg
sudo easy_install /tmp/mesos.egg


##Installation and Configuration of Marathon
curl -fL http://downloads.mesosphere.io/marathon/marathon_0.5.0-xcon2_noarch.deb -o /tmp/marathon.deb
sudo dpkg -i /tmp/marathon.deb

## Restarting your environment
sudo initctl reload-configuration
sudo start docker.io || sudo restart docker.io
sudo start zookeeper || sudo restart zookeeper
sudo start mesos-master || sudo restart mesos-master
sudo start mesos-slave || sudo restart mesos-slave

## Installation and configuration of Deimos
sudo pip install deimos


##Configuration of Mesos to use Deimos
sudo mkdir -p /etc/mesos-slave

## Configure Deimos as a containerizer
echo /usr/local/bin/deimos | sudo dd of=/etc/mesos-slave/containerizer_path
echo external              | sudo dd of=/etc/mesos-slave/isolation

##Restart Marathon.
sudo initctl reload-configuration
sudo start marathon || sudo restart marathon