# ArangoDB with S3 Backups
This package extends the default [ArangoDB](https://github.com/arangodb/arangodb-docker) image and adds functionality to
run backups on a cron job and upload them to AWS S3.


## Building the image

Clone the repository

        git clone https://github.com/rhoai/docker-arangodb.git
        cd docker-wordpress
        ./build.sh

The default tag for the new image is rhoai/arangodb. If you want to specify a
different tag, pass the -t flag along with the tag name:

    ./build.sh -t new/tag

## Environment Variables

SERVER_HOST: Host to connect to when performing the data export. Defaults to
127.0.0.1

AWS_ACCESS_KEY_ID: The AWS Access Key Id that has access to the S3 bucket

AWS_SECRET_ACCESS_KEY: The corresponding secret key for the key above

AWS_DEFAULT_REGION: Region where bucket is located. Defaults to us-east-1

S3_BACKUP_PATH: S3 path where backups will be stored. Example:

BACKUP_CRON_TIME: Cron time for scheduling the backup

```
s3://bucket_name/folder1/folder2
```

## License
See the license file.

## Contributors

* [Alejadnro Mesa](https://github.com/alejom99)
