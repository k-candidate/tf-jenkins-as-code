FROM jenkins/jenkins:2.492.1-lts-jdk17
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc.yaml
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
# Switch to root to install additional packages
USER root
RUN apt-get update && apt-get install -y libvirt-dev
# drop back to the regular jenkins user - good practice
USER jenkins