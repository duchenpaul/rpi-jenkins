# Jenkins Docker image for Raspberry Pi

A basic Jenkins image that's compatible with Raspberry Pi. Automated builds are pushed whenever a new version of Jenkins becomes available.

### Supported tags and respective `Dockerfile` links

- [`2.62`](https://github.com/wouterds/rpi-jenkins/tree/2.62/Dockerfile), [`2.63`](https://github.com/wouterds/rpi-jenkins/tree/2.63/Dockerfile),  [`2.64`, `latest` (*Dockerfile*)](https://github.com/wouterds/rpi-jenkins/tree/2.64/Dockerfile)

### What is Jenkins?

Jenkins is an open source automation server written in Java. The project was forked from Hudson after a dispute with Oracle. Jenkins helps to automate the non-human part of the whole software development process, with now common things like continuous integration, but by further empowering teams to implement the technical part of a Continuous Delivery.

> [wikipedia.org/wiki/Jenkins_(software)](http://en.wikipedia.org/wiki/Jenkins_(software))

![logo](https://raw.githubusercontent.com/docker-library/docs/3ab4dafb41dd0e959ff9322b3c50af2519af6d85/jenkins/logo.png)

### Usage

This will store the workspace in /var/jenkins_home. All Jenkins data lives in there - including plugins and configuration.
You will probably want to make that an explicit volume so you can manage it and attach to another container for upgrades :

```bash
docker build . -t rpi-jenkins && docker images prune -f
docker container run \
  --name jenkins \
  -d \
  --publish 18080:8080 \
  --publish 50000:50000 \
  --volume /home/pi/docker_files/jenkins/data:/var/jenkins_home \
  --volume /home/pi/docker_files/jenkins/jenkins-docker-certs:/certs/client:ro \
rpi-jenkins
```

or use docker-compose
```bash
docker-compose up -d --build && docker image prune -f
```


this will automatically create a 'jenkins' volume on docker host, that will survive container stop/restart/deletion.

## 国内plugin加速
```bash
# In docker: 
# go to JENKINS_HOME
cd /var/jenkins_home/updates
sed -i 's/http:\/\/updates.jenkins-ci.org\/download/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins/g' default.json
```



---

This image is available on [GitHub](https://github.com/wouterds/rpi-jenkins) & [DockerHub](https://hub.docker.com/r/wouterds/rpi-jenkins).
