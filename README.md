# ownCloud: Appliance

[![Build Status](https://drone.owncloud.com/api/badges/owncloud-docker/appliance/status.svg)](https://drone.owncloud.com/owncloud-docker/appliance)
[![](https://images.microbadger.com/badges/image/owncloud/appliance.svg)](https://microbadger.com/images/owncloud/appliance "Get your own image badge on microbadger.com")

This is a custom image used within our Univention appliance, please don't use this as a regular Docker container, it is built from our [base container](https://registry.hub.docker.com/u/owncloud/base/).


## Versions

To get an overview about the available versions please take a look at the [GitHub branches](https://github.com/owncloud-docker/appliance/branches/all) or our [Docker Hub tags](https://hub.docker.com/r/owncloud/appliance/tags/), these lists are always up to date. Please note that release candidates or alpha/beta versions are only temporary available, they will be removed after the final release of a version.


## Volumes

* /mnt/data


## Ports

* 80
* 443


## Available environment variables

```

```

## Inherited environment variables

* [owncloud/base](https://github.com/owncloud-docker/base#available-environment-variables)
* [owncloud/php](https://github.com/owncloud-docker/php#available-environment-variables)
* [owncloud/ubuntu](https://github.com/owncloud-docker/ubuntu#available-environment-variables)


## Build locally

The available versions should be already pushed to the Docker Hub, but in case you want to try a change locally you can always execute the following command (run from a cloned GitHub repository) to get an image built locally:

```
wget https://download.owncloud.org/community/owncloud-10.0.10.tar.bz2
wget https://github.com/owncloud/richdocuments/releases/download/2.0.8/richdocuments.tar.gz
wget https://github.com/owncloud/user_ldap/releases/download/v0.11.0/user_ldap.tar.gz
wget https://github.com/ONLYOFFICE/onlyoffice-owncloud/releases/download/v2.0.3/onlyoffice.tar.gz

docker pull owncloud/base:xenial
docker build -t owncloud/appliance:latest .
```


## Issues, Feedback and Ideas

Open an [Issue](https://github.com/owncloud-docker/appliance/issues)


## Contributing

Fork -> Patch -> Push -> Pull Request


## Authors

* [Thomas Boerger](https://github.com/tboerger)
* [Felix Boehm](https://github.com/felixboehm)


## License

MIT


## Copyright

```
Copyright (c) 2018 Thomas Boerger <tboerger@owncloud.com>
```
