FROM jenkins/jenkins:lts

USER jenkins
RUN id

USER root
RUN chown -R jenkins:jenkins /var/jenkins_home

# Bind-mounted jenkins_home: host UID/Git; global config in /var/jenkins_home is hidden by the mount.
RUN printf '[safe]\n\tdirectory = *\n' > /etc/gitconfig

# Docker Engine (dockerd) + CLI. Pipelines use `docker run hashicorp/terraform:…` — no terraform binary here.
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl gosu \
  && install -m 0755 -d /etc/apt/keyrings \
  && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
  && chmod a+r /etc/apt/keyrings/docker.asc \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" > /etc/apt/sources.list.d/docker.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io \
  && groupadd -f docker \
  && usermod -aG docker jenkins \
  && rm -rf /var/lib/apt/lists/* \
  && docker --version

COPY jenkins-dockerd-entrypoint.sh /usr/local/bin/jenkins-dockerd-entrypoint.sh
RUN chmod +x /usr/local/bin/jenkins-dockerd-entrypoint.sh \
  && TINI="$(command -v tini)" && test -n "$TINI" && test -x "$TINI" \
  && ln -sf "$TINI" /usr/local/bin/tini-jenkins

USER jenkins

# install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

USER root
ENV DOCKER_HOST=unix:///var/run/docker.sock
ENTRYPOINT ["/usr/local/bin/tini-jenkins", "--", "/usr/local/bin/jenkins-dockerd-entrypoint.sh"]
