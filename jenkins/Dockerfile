FROM jenkins/jenkins
ENV JENKINS_USER admin
ENV JENKINS_PASS admin
# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli --plugins $(cat /usr/share/jenkins/plugins.txt)
COPY job1_config.xml /usr/share/jenkins/ref/jobs/hello_world/config.xml
COPY job2_config.xml /usr/share/jenkins/ref/jobs/ping_job/config.xml
USER root
RUN apt-get update && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common iputils-ping
RUN curl -fsSL "https://download.docker.com/linux/debian/gpg" | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update -qq && apt-get install docker-ce -y && apt-get clean
RUN usermod -aG docker jenkins
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
USER jenkins
