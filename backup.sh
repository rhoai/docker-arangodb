#!/bin/bash

set -e

BACKUP_DIR_NAME="ARANGODB_`date +"%m%d%Y_%H%M%S"`"
BACKUP_FILE="${BACKUP_DIR_NAME}.tar.gz"
: ${SERVER_HOST='127.0.0.1'}

# Export the data from arangodb
/usr/bin/arangodump \
  --output-directory /tmp/$BACKUP_DIR_NAME \
  --server.endpoint "tcp://$SERVER_HOST:8529" \
  --server.database $DATABASE_NAME \
  --server.username $DATABASE_USERNAME \
  --server.password $DATABASE_PASSWORD \
  --server.max-packet-size 256M

# Create tar file
/bin/tar -zcf /tmp/$BACKUP_FILE /tmp/$BACKUP_DIR_NAME

# Copy file to s3
/usr/local/bin/aws s3 cp /tmp/$BACKUP_FILE "${S3_BACKUP_PATH}/${BACKUP_FILE}"

# Clean up
rm -rf /tmp/ARANGODB_*

echo "ArangoDB backup completed"
