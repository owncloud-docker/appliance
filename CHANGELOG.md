# Changelog

## 2019-07-04

10.2.1 update:

* Changed
	* Upgrade oC version from 10.1.1 to 10.2.1 inc. SHA256
	* Upgrade onlyoffice from 2.1.7 to 2.3.1 inc. SHA256

## 2018-10-09

* Changed
  * Prepare for new `owncloud/base` image
  * Changed port from `80` to `8080`
* Removed
  * Dropped port `443`, use a reverse proxy for SSL

## 2018-10-01

* Added
  * Integrate clair vuln checks
* Changed
  * Upgrade ownCloud from 10.0.9 to 10.0.10
  * Upgrade richdocuments from 2.0.6 to 2.0.8
  * Upgrade onlyoffice from 1.3.0 to 2.0.3
  * Switch base image from xenial to bionic
* Removed
  * Dropped matrix builds
