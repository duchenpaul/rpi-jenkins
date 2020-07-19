FROM arm32v7/ubuntu

ENV DEBIAN_FRONTEND=noninteractive

ENV TZ Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone

# Base image: ubuntu
RUN sed -i 's/ports.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install tzdata curl git

# Jenkins version
ENV JENKINS_VERSION 2.99

# Other env variables
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000

# Enable cross build
# RUN ["cross-build-start"]

# Install dependencies
RUN apt-get install -y --no-install-recommends openjdk-8-jdk \
  && rm -rf /var/lib/apt/lists/*

# Get Jenkins
# official
# RUN curl -fL -o /opt/jenkins.war https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/{$JENKINS_VERSION}/jenkins-war-{$JENKINS_VERSION}.war
# Tsinghua
RUN curl -fL -o /opt/jenkins.war https://mirrors.tuna.tsinghua.edu.cn/jenkins/war/latest/jenkins.war

# Disable cross build
# RUN ["cross-build-end"]

# Expose volume
VOLUME ${JENKINS_HOME}

# Working dir
WORKDIR ${JENKINS_HOME}

# Expose ports
EXPOSE 8080 ${JENKINS_SLAVE_AGENT_PORT}

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://127.0.0.1:8080/login || exit 1
# Start Jenkins
CMD ["sh", "-c", "java -jar /opt/jenkins.war"]
