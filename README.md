# ownCloud: Appliance

[![Build Status](https://drone.owncloud.com/api/badges/owncloud-docker/appliance/status.svg)](https://drone.owncloud.com/owncloud-docker/appliance)
[![](https://images.microbadger.com/badges/image/owncloud/appliance.svg)](https://microbadger.com/images/owncloud/appliance "Get your own image badge on microbadger.com")

This is a custom image used within our Univention appliance, please don't use this as a regular Docker container, it is built from our [base container](https://registry.hub.docker.com/u/owncloud/base/).

For a guide how to get started with this Docker image please take a look at our [official documentation](https://doc.owncloud.com/server/latest/admin_manual/appliance/installation/installation.html).

## Versions

[Docker Hub](https://hub.docker.com/r/owncloud/appliance/tags)

- `latest` available as `owncloud/appliance:latest`
- `10.7.0` available as `owncloud/appliance:10.7.0`, `owncloud/appliance:10.7`, `owncloud/appliance:10`
- `10.6.0` available as `owncloud/appliance:10.6.0`, `owncloud/appliance:10.6`
- `10.4.0` available as `owncloud/appliance:10.4.0`, `owncloud/appliance:10.4`
- `10.3.2` available as `owncloud/appliance:10.3.2`, `owncloud/appliance:10.3`
- `10.2.1` available as `owncloud/appliance:10.2.1`, `owncloud/appliance:10.2`

## Volumes

- /mnt/data

## Ports

- 8080

## Available environment variables

None

## Inherited environment variables

- [owncloud/base](https://github.com/owncloud-docker/base#available-environment-variables)
- [owncloud/php](https://github.com/owncloud-docker/php#available-environment-variables)
- [owncloud/ubuntu](https://github.com/owncloud-docker/ubuntu#available-environment-variables)

## License

MIT

## Copyright

```Text
Copyright (c) 2021 ownCloud GmbH
```
