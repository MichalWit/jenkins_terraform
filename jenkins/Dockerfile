FROM jenkins/jenkins:lts

USER jenkins
RUN id

USER root
RUN chown -R jenkins:jenkins /var/jenkins_home
RUN mkdir -p /home/jenkins/test_repo
RUN chown -R jenkins:jenkins /home/jenkins/test_repo
RUN git config --global --add safe.directory /home/jenkins/test_repo/.git
# Bind-mounted jenkins_home keeps host ownership; Git 2.35+ (CVE-2022-24765) then rejects
# those repos unless trusted. Global config in /var/jenkins_home is hidden by the mount.
RUN printf '[safe]\n\tdirectory = *\n' > /etc/gitconfig

# Docker CLI only (daemon stays on the host). docker-compose mounts the socket as DooD.
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl \
  && install -m 0755 -d /etc/apt/keyrings \
  && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
  && chmod a+r /etc/apt/keyrings/docker.asc \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list \
  && apt-get update && apt-get install -y --no-install-recommends docker-ce-cli \
  && rm -rf /var/lib/apt/lists/*

USER jenkins

# install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

