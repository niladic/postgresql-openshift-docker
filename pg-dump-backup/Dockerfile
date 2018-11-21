FROM centos/postgresql-10-centos7
# https://github.com/sclorg/postgresql-container/blob/generated/10/Dockerfile

USER 0

RUN mkdir /var/backups
RUN /usr/libexec/fix-permissions /var/backups
VOLUME ["/var/backups"]

ADD backup.sh /
RUN chmod +x /backup.sh

USER 26
CMD ["sh", "/backup.sh"]
