FROM centos/postgresql-10-centos7
# https://github.com/sclorg/postgresql-container/blob/generated/10/Dockerfile

USER 0

ENV ARCHIVE_MODE yes

# Python
RUN yum -y install rh-python36
RUN yum -y install epel-release
RUN yum -y install python36-setuptools
RUN easy_install-3.6 pip

# wal-e
RUN pip3 install wal-e
RUN mkdir -p /var/backups
RUN /usr/libexec/fix-permissions /var/backups
RUN  echo -e '\
wal_level = archive \n\
archive_mode = ${ARCHIVE_MODE} \n\
archive_command = '/usr/local/bin/wal-e wal-push %p' \n\
archive_timeout = 60'\
>> /usr/share/container-scripts/postgresql/openshift-custom-postgresql.conf.template

VOLUME ["/var/backups"]

USER 26
