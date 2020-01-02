FROM centos/postgresql-10-centos7
# https://github.com/sclorg/postgresql-container/blob/generated/10/Dockerfile

USER 0

ENV RECIPIENT_PUBLIC_KEY ""
ENV RECIPIENT_PUBLIC_KEY_EMAIL ""
ENV AWS_ACCESS_KEY_ID ""
ENV AWS_SECRET_ACCESS_KEY ""
ENV AWS_DEFAULT_REGION ""
ENV AWS_BUCKET_NAME ""

RUN yum install -y epel-release
RUN yum install -y python-pip
RUN pip install --upgrade awscli==1.14.5 s3cmd==2.0.1 python-magic

RUN mkdir /var/backups
RUN /usr/libexec/fix-permissions /var/backups
VOLUME ["/var/backups"]

ADD backup.sh /
RUN chmod +x /backup.sh

USER 26
CMD ["sh", "/backup.sh"]
