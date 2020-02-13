FROM centos/postgresql-10-centos7
# https://github.com/sclorg/postgresql-container/blob/generated/10/Dockerfile

USER 0

ENV RECIPIENT_PUBLIC_KEY_B64 ""
ENV RECIPIENT_PUBLIC_KEY_EMAIL ""
ENV AWS_ACCESS_KEY_ID ""
ENV AWS_SECRET_ACCESS_KEY ""
ENV S3_REGION ""
ENV S3_BUCKET_NAME ""
ENV S3_HOSTNAME ""
ENV S3_HOSTBUCKET ""

RUN yum install -y epel-release
RUN yum install -y python-pip
RUN pip install --upgrade s3cmd==2.0.2

RUN mkdir /var/backups
RUN /usr/libexec/fix-permissions /var/backups
VOLUME ["/var/backups"]

ADD backup.sh /
RUN chmod +x /backup.sh

USER 26
CMD ["sh", "/backup.sh"]
