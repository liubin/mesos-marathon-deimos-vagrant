Mesos + Marathon + Deimos on Vagrant example
=============================

Basically under the instruction of http://mesosphere.io/learn/run-docker-on-mesosphere/

#Requirements(Tested on):

* VirtualBox: 4.3.12+
* Vagrant: 1.5.0

#Howto Use

##Setup Vagrant

In your host run.

```
$ git clone git@github.com:liubin0329/mesos-marathon-deimos-vagrant.git
$ cd mesos-marathon-deimos-vagrant
$ vagrant up
```

this will take a long time to complete.

##Pull ubuntu Docker Image

From here run in Ubuntu VM.

```
$ docker pull ubuntu
```

this may take a long time too.

##Submit a job

```
$ cd /vagrant
$ curl -X POST -H "Content-Type: application/json" localhost:8080/v2/apps -d@job.json
```

##Confirm

use one of below to confirm the result.

* On http://localhost:8080/ to confirm that the job has running task.
* On http://localhost:8090/ to confirm that you can see the "Hello World"
* use `sudo docker ps` to conrim the conatiner is running.

##Attention

I failed when submit a job with CPU share rate is set to `.5` as offical document, that lead mesos can not find a node to execute the job.So I changed it to `.1`, at least as an example it can run now.

#Feedback

welcome to liubin0329@gmail.com

