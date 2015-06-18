itamae-server
=============

**This is under development and not ready to use!**

## Usage

```
$ vim .env
$ bin/rails s
```

## Configuration

### Backend

#### Consul Backend

### Storage

Storage will be used to store recipe tarball and execution log.

#### Local Storage

This storage type is used by default. Files will be stored under `public/files`.

```
STORAGE_TYPE=local
```

#### S3 Storage

```
AWS_ACCESS_KEY_ID=yourkey
AWS_SECRET_ACCESS_KEY=yoursecret
S3_BUCKET=your-s3-bucket
S3_ROOT_DIRECTORY=itamae-server
STORAGE_TYPE=s3
```

