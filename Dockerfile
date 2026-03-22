FROM jenkins/jenkins:lts

USER jenkins
RUN id

USER root
RUN chown -R jenkins:jenkins /var/jenkins_home
RUN mkdir -p /home/jenkins/test_repo
RUN chown -R jenkins:jenkins /home/jenkins/test_repo
RUN git config --global --add safe.directory /home/jenkins/test_repo/.git

USER jenkins

# install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

