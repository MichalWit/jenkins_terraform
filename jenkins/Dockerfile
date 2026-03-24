FROM jenkins/jenkins:lts

ARG TERRAFORM_VERSION=1.14.7

USER jenkins
RUN id

USER root
RUN chown -R jenkins:jenkins /var/jenkins_home
RUN mkdir -p /home/jenkins/test_repo
RUN chown -R jenkins:jenkins /home/jenkins/test_repo
RUN git config --global --add safe.directory /home/jenkins/test_repo/.git
# Bind-mounted jenkins_home: host UID/Git; global config in /var/jenkins_home is hidden by the mount.
RUN printf '[safe]\n\tdirectory = *\n' > /etc/gitconfig

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl unzip \
  && ARCH=$(dpkg --print-architecture) \
  && case "$ARCH" in amd64) TF_ARCH=amd64 ;; arm64) TF_ARCH=arm64 ;; *) echo "unsupported arch: $ARCH" >&2; exit 1 ;; esac \
  && curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TF_ARCH}.zip" -o /tmp/terraform.zip \
  && unzip -o /tmp/terraform.zip -d /usr/local/bin \
  && rm /tmp/terraform.zip \
  && rm -rf /var/lib/apt/lists/* \
  && terraform version

USER jenkins

# install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
