# ownCloud: Appliance

[![Build Status](https://img.shields.io/drone/build/owncloud-docker/appliance?logo=drone&server=https%3A%2F%2Fdrone.owncloud.com)](https://drone.owncloud.com/owncloud-docker/appliance)
[![Docker Hub](https://img.shields.io/docker/v/owncloud/appliance?logo=docker&label=dockerhub&sort=semver&logoColor=white)](https://hub.docker.com/r/owncloud/appliance)
[![GitHub contributors](https://img.shields.io/github/contributors/owncloud-docker/appliance)](https://github.com/owncloud-docker/appliance/graphs/contributors)
[![Source: GitHub](https://img.shields.io/badge/source-github-blue.svg?logo=github&logoColor=white)](https://github.com/owncloud-docker/appliance)
[![License: MIT](https://img.shields.io/github/license/owncloud-docker/appliance)](https://github.com/owncloud-docker/appliance/blob/master/LICENSE)

Custom ownCloud Docker image used within the Univention appliance, please don't use this as a regular Docker container! For a guide how to get started please take a look at our [documentation](https://doc.owncloud.com/server/latest/admin_manual/appliance/installation/installation.html).

> **IMPORTANT:** We had to change the behavior of the ownCloud setting for trusted domains. Instead of automatic detection, it is now required to set all trusted domains with the environment variable "OWNCLOUD_TRUSTED_DOMAINS".

## Quick reference

- **Where to file issues:**\
  [owncloud-docker/appliance](https://github.com/owncloud-docker/appliance/issues)

- **Supported architectures:**\
  `amd64`

- **Inherited environments:**\
  [owncloud/ubuntu](https://github.com/owncloud-docker/ubuntu#environment-variables),
  [owncloud/php](https://github.com/owncloud-docker/php#environment-variables),
  [owncloud/base](https://github.com/owncloud-docker/base#environment-variables)

## Docker Tags and respective Dockerfile links

- [`latest`](https://github.com/owncloud-docker/appliance/blob/master/v20.04/Dockerfile.amd64) available as `owncloud/appliance:latest`
- [`10.12.2`](https://github.com/owncloud-docker/appliance/blob/master/v20.04/Dockerfile.amd64) available as `owncloud/appliance:10.12.2`, `owncloud/appliance:10.12`, `owncloud/appliance:10`
- [`10.11.0`](https://github.com/owncloud-docker/appliance/blob/master/v20.04/Dockerfile.amd64) available as `owncloud/appliance:10.11.0`

## Default volumes

- `/mnt/data`

## Exposed ports

- 8080

## Environment variables

None

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/owncloud-docker/appliance/blob/master/LICENSE) file for details.

## Copyright

```Text
Copyright (c) 2022 ownCloud GmbH
```
