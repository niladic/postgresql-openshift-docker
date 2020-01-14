#!/bin/bash
# Inspired from https://gist.github.com/skyebook/3407646
# and https://gist.github.com/shaiton/e505608c0b3bc9bc5aac

NOW="$(date +"%Y-%m-%d-%s")"
FILENAME="$DATABASE_BACKUP_PATH/$DATABASE_NAME.$NOW.backup.gz"
find $DATABASE_BACKUP_PATH -name $DATABASE_NAME.*backup* -type f -mtime +$RETENTION_DAYS -exec rm '{}' \;
pg_dump -Fc $DATABASE_URL | gzip > $FILENAME

if [ -z "${RECIPIENT_PUBLIC_KEY_B64}" ]
then
      echo "Do no upload backup : RECIPIENT_PUBLIC_KEY_B64 is empty."
      exit 0
fi

echo ${RECIPIENT_PUBLIC_KEY_B64} | base64 --decode > ./${RECIPIENT_PUBLIC_KEY_EMAIL}.asc
gpg --no-tty --import ${RECIPIENT_PUBLIC_KEY_EMAIL}.asc
gpg --batch --trust-model always --output "${FILENAME}.gpg" --recipient ${RECIPIENT_PUBLIC_KEY_EMAIL} --encrypt ${FILENAME}

aws s3 cp "${FILENAME}.gpg" s3://${AWS_BUCKET_NAME}

rm "${FILENAME}.gpg"
