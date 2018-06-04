# Docker image appliance-server
custom ownCloud server docker image for univention appliance

Based on [owncloud/server](https://github.com/owncloud-docker/server)

## Build local

# Fetch richdocuments from marketplace, currently github release is built not correct https://github.com/owncloud/richdocuments/issues/214

```
# wget https://github.com/owncloud/richdocuments/archive/2.0.5.tar.gz -O richdocuments-2.0.5.tar.gz

docker pull owncloud/server:latest
docker build -t owncloud/appliance-server:latest .
```

## Publish

after testing

```
docker push owncloud/appliance-server:latest
```
