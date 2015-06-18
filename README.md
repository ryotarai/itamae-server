itamae-server
=============

**This is under development and not ready to use!**

## Usage

```
$ vim .env
$ bin/rails s
```

## Configuration

### Authentication

By default, users can access itamae-server without any authentication.

#### Google

```
GOOGLE_CLIENT_ID=yourid
GOOGLE_CLIENT_SECRET=yoursecret
```

Optionally, you can restrict hosted domain:

```
GOOGLE_HOSTED_DOMAIN=example.com
```

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

