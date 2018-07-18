#!/bin/bash

: ${S3_BACKUP_PATH:=''}
: ${BACKUP_CRON_TIME:='0 6 * * *'}
: ${AWS_DEFAULT_REGION:='us-east-1'}

CRON_LOG="/var/log/cron.log"


# Create the log output file (PIPE) if it does not exist
if [ ! -p $CRON_LOG ]; then
  mkfifo $CRON_LOG
fi

# Create the cron job
echo "S3_BACKUP_PATH=${S3_BACKUP_PATH}" > /etc/cron.d/arango_backup
echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}" >> /etc/cron.d/arango_backup
echo "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}" >> /etc/cron.d/arango_backup
echo "AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}" >> /etc/cron.d/arango_backup
echo "SERVER_HOST=${SERVER_HOST}" >> /etc/cron.d/arango_backup
echo "DATABASE_NAME=${DATABASE_NAME}" >> /etc/cron.d/arango_backup
echo "DATABASE_USERNAME=${DATABASE_USERNAME}" >> /etc/cron.d/arango_backup
echo "DATABASE_PASSWORD=${DATABASE_PASSWORD}" >> /etc/cron.d/arango_backup
echo "${BACKUP_CRON_TIME} root /backup.sh >> /var/log/cron.log 2>&1" >> /etc/cron.d/arango_backup

# start cron
echo "Starting cron ..."
cron

tail -f $CRON_LOG
