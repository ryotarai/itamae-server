itamae-server
=============

**This is under development and not ready to use!**

## Usage

```
$ vim .env
$ bin/rails s
```

## Playground

```
$ cd playground
$ vagrant up
$ ./start-consul-server
==> WARNING: BootstrapExpect Mode is specified as 1; this is the same as Bootstrap mode.
==> WARNING: Bootstrap mode enabled! Do not enable unless necessary
==> WARNING: It is highly recommended to set GOMAXPROCS higher than 1
==> Starting Consul agent...
==> Starting Consul agent RPC...
==> Consul agent running!
         Node name: 'vagrant-ubuntu-trusty-64'
        Datacenter: 'dc1'
            Server: true (bootstrap: true)
       Client Addr: 0.0.0.0 (HTTP: 8500, HTTPS: -1, DNS: 8600, RPC: 8400)
      Cluster Addr: 10.0.2.15 (LAN: 8301, WAN: 8302)
    Gossip encrypt: false, RPC-TLS: false, TLS-Incoming: false
             Atlas: <disabled>
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

```
BACKEND_TYPE=consul
CONSUL_SERVICE=itamae
CONSUL_EVENT=itamae-server-event             # optional
CONSUL_ABORT_EVENT=itamae-server-abort-event # optional
CONSUL_URL=http://consul:8500                # optional
```

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
