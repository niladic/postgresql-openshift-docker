#!/bin/bash
# Inspired from https://gist.github.com/skyebook/3407646
# and https://gist.github.com/shaiton/e505608c0b3bc9bc5aac

set -e 

NOW="$(date +"%Y-%m-%d-%s")"
FILENAME="backup.$NOW.gz"
tar -C $DIR_CD -xcf $FILENAME $FILES_TO_BACKUP

set -x

echo "$S3CMD_S3CFG" > ~/.s3cfg
s3cmd -v put "${FILENAME}" s3://${S3_BUCKET_NAME}

rm "${FILENAME}"
