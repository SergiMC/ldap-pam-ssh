# Version: 0.0.1
# @edt Sergi Muñoz M06 2018-2019
# SSH server
# -------------------------------------
FROM fedora:27
LABEL author="@edt Sergi Muñoz ASIX M06-ASO"
LABEL description="Server SSH 2018-2019"
RUN dnf -y install procps passwd openldap-clients nss-pam-ldapd authconfig pam_mount openssh-server
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]
