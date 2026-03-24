FROM jenkins/jenkins:lts

USER jenkins
RUN id

USER root
RUN chown -R jenkins:jenkins /var/jenkins_home

# Bind-mounted jenkins_home: host UID/Git; global config in /var/jenkins_home is hidden by the mount.
RUN printf '[safe]\n\tdirectory = *\n' > /etc/gitconfig

# Docker CLI only — daemon is the docker:dind service (DOCKER_HOST in docker-compose.yml).
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl \
  && install -m 0755 -d /etc/apt/keyrings \
  && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
  && chmod a+r /etc/apt/keyrings/docker.asc \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends docker-ce-cli \
  && rm -rf /var/lib/apt/lists/* \
  && docker --version

USER jenkins

# install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
