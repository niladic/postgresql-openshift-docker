#!/bin/bash
# Inspired from https://gist.github.com/skyebook/3407646
# and https://gist.github.com/shaiton/e505608c0b3bc9bc5aac

set -e 

NOW="$(date +"%Y-%m-%d-%s")"
FILENAME="$DATABASE_BACKUP_PATH/$DATABASE_NAME.$NOW.backup.gz"
find $DATABASE_BACKUP_PATH -name $DATABASE_NAME.*backup* -type f -mtime +$RETENTION_DAYS -exec rm '{}' \;
pg_dump -Fc $DATABASE_URL | gzip > $FILENAME

if [ -z "${RECIPIENT_PUBLIC_KEY}" ]
then
      echo "Do no upload backup : RECIPIENT_PUBLIC_KEY is empty."
      exit 0
fi

echo "${RECIPIENT_PUBLIC_KEY}" | gpg --no-tty --import
set -x
gpg --batch --trust-model always --output "${FILENAME}.gpg" --recipient ${RECIPIENT_PUBLIC_KEY_EMAIL} --encrypt ${FILENAME}

echo "$S3CMD_S3CFG" > ~/.s3cfg
s3cmd -v put "${FILENAME}.gpg" s3://${S3_BUCKET_NAME}

rm "${FILENAME}.gpg"
