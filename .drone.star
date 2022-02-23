def main(ctx):
    versions = [
        {
            "value": "10.9.1",
            "qa": "https://download.owncloud.org/community/testing/owncloud-complete-20220112-qa.tar.bz2",
            "tarball": "https://download.owncloud.org/community/owncloud-complete-20220112.tar.bz2",
            "tarball_sha": "3ab3478aee75d6aa6c47db2bc8749a108917df633f2cfab7e8ff67973c2f6147",
            "ldap": "https://github.com/owncloud/user_ldap/releases/download/v0.16.0/user_ldap-0.16.0.tar.gz",
            "ldap_sha": "91ac533b4b6e0d6647c01ac4846b62c00c643cb9554be2a378209de5a0538555",
            "openidconnect": "https://marketplace.owncloud.com/api/v1/apps/openidconnect/2.1.0",
            "openidconnect_sha": "418e7c76e0d1837595537ec0106bc960f5c9ab40fa0235e7ba056e6c0582471c",
            "onlyoffice": "https://marketplace.owncloud.com/api/v1/apps/onlyoffice/7.2.3",
            "onlyoffice_sha": "c166995effb9f80a5a4446b59f861258bb4f4153003417adbe5d1e467db17b30",
            "richdocuments": "https://marketplace.owncloud.com/api/v1/apps/richdocuments/2.6.0",
            "richdocuments_sha": "9401ec944b5b00a4b66c88ec7cf2c2626cb0330cfe5eb7cc0ad8ee815de382aa",
            "php": "7.4",
            "base": "v20.04",
            "tags": ["10.9", "10"],
        },
        {
            "value": "latest",
            "qa": "https://download.owncloud.org/community/testing/owncloud-complete-20220112-qa.tar.bz2",
            "tarball": "https://download.owncloud.org/community/owncloud-complete-20220112.tar.bz2",
            "tarball_sha": "3ab3478aee75d6aa6c47db2bc8749a108917df633f2cfab7e8ff67973c2f6147",
            "ldap": "https://github.com/owncloud/user_ldap/releases/download/v0.16.0/user_ldap-0.16.0.tar.gz",
            "ldap_sha": "91ac533b4b6e0d6647c01ac4846b62c00c643cb9554be2a378209de5a0538555",
            "openidconnect": "https://marketplace.owncloud.com/api/v1/apps/openidconnect/2.1.0",
            "openidconnect_sha": "418e7c76e0d1837595537ec0106bc960f5c9ab40fa0235e7ba056e6c0582471c",
            "onlyoffice": "https://marketplace.owncloud.com/api/v1/apps/onlyoffice/7.2.3",
            "onlyoffice_sha": "c166995effb9f80a5a4446b59f861258bb4f4153003417adbe5d1e467db17b30",
            "richdocuments": "https://marketplace.owncloud.com/api/v1/apps/richdocuments/2.6.0",
            "richdocuments_sha": "9401ec944b5b00a4b66c88ec7cf2c2626cb0330cfe5eb7cc0ad8ee815de382aa",
            "php": "7.4",
            "behat_version": "v10.9.1",
            "base": "v20.04",
            "tags": [],
        },
        {
            "value": "10.8.0",
            "qa": "https://download.owncloud.org/community/testing/owncloud-complete-20210721-qa.tar.bz2",
            "tarball": "https://download.owncloud.org/community/owncloud-complete-20210721.tar.bz2",
            "tarball_sha": "c98afec32d2047be12a7a2724ef27a61ef42dc7175fcf8368813ff39d22d55d8",
            "ldap": "https://github.com/owncloud/user_ldap/releases/download/v0.15.4/user_ldap-0.15.4.tar.gz",
            "ldap_sha": "84412529b941723ef9523fe3c6d7c43cf2e44ab2522a9a9933966228f96122de",
            "openidconnect": "https://marketplace.owncloud.com/api/v1/apps/openidconnect/2.0.0",
            "openidconnect_sha": "7ca18612288e0806d34caa74a0e0cf34347461029b6a818b724b8896ee88a307",
            "onlyoffice": "https://marketplace.owncloud.com/api/v1/apps/onlyoffice/6.4.3",
            "onlyoffice_sha": "432d1c9723c99448cdc361a87380072a674bea47827ce5742953670fd1e04f74",
            "richdocuments": "https://marketplace.owncloud.com/api/v1/apps/richdocuments/2.5.0",
            "richdocuments_sha": "51289898ee2c360e6be332b8b3561953014cb9901f35232e63d5a7530b1d353a",
            "php": "7.4",
            "base": "v20.04",
            "tags": ["10.8"],
        },
        {
            "value": "10.7.0",
            "qa": "https://download.owncloud.org/community/testing/owncloud-complete-20210326-qa.tar.bz2",
            "tarball": "https://download.owncloud.org/community/owncloud-complete-20210326.tar.bz2",
            "tarball_sha": "a5506e1fc7abd7634dc3daaf005a4ccd0151a63c9f23aa979efebefaeb40e79c",
            "ldap": "https://github.com/owncloud/user_ldap/releases/download/v0.15.2/user_ldap-0.15.2.tar.gz",
            "ldap_sha": "2c4cdd4f08c7b9541761afddf9ac33210619fc21c62463b0834dc651e12ecf87",
            "onlyoffice": "https://marketplace.owncloud.com/api/v1/apps/onlyoffice/6.3.1",
            "onlyoffice_sha": "ea909dbba090b3780d98c9ff10df8e8ae66ed2a85105c222df523964db37d99f",
            "openidconnect": "https://marketplace.owncloud.com/api/v1/apps/openidconnect/2.0.0",
            "openidconnect_sha": "7ca18612288e0806d34caa74a0e0cf34347461029b6a818b724b8896ee88a307",
            "richdocuments": "https://marketplace.owncloud.com/api/v1/apps/richdocuments/2.4.1",
            "richdocuments_sha": "4e6210c125fc83e3b575b835323eed3129d17b306c798c0b755206789363dcc3",
            "php": "7.4",
            "base": "v20.04",
            "tags": ["10.7"],
        },
    ]

    arches = [
        "amd64",
    ]

    config = {
        "version": None,
        "arch": None,
        "split": 6,
        "description": "ownCloud image for the Univention appliance",
        "repo": ctx.repo.name,
    }

    stages = []

    for version in versions:
        config["version"] = version

        m = manifest(config)
        inner = []

        for arch in arches:
            config["arch"] = arch

            if config["version"]["value"] == "latest":
                config["tag"] = arch
            else:
                config["tag"] = "%s-%s" % (config["version"]["value"], arch)

            if config["arch"] == "amd64":
                config["platform"] = "amd64"

            if config["arch"] == "arm64v8":
                config["platform"] = "arm64"

            if config["arch"] == "arm32v7":
                config["platform"] = "arm"

            config["internal"] = "%s-%s-%s" % (ctx.build.commit, "${DRONE_BUILD_NUMBER}", config["tag"])

            for d in docker(config):
                d["depends_on"].append(checkStarlark()["name"])
                m["depends_on"].append(d["name"])
                inner.append(d)

        inner.append(m)
        stages.extend(inner)

    after = [
        documentation(config),
        rocketchat(config),
    ]

    for s in stages:
        for a in after:
            a["depends_on"].append(s["name"])

    return [checkStarlark()] + stages + after

def docker(config):
    pre = [{
        "kind": "pipeline",
        "type": "docker",
        "name": "prepublish-%s-%s" % (config["arch"], config["version"]["value"]),
        "platform": {
            "os": "linux",
            "arch": config["platform"],
        },
        "steps": tarball(config) + ldap(config) + richdocuments(config) + onlyoffice(config) + openidconnect(config) + prepublish(config) + sleep(config) + trivy(config),
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/pull/**",
            ],
        },
    }]

    post = [{
        "kind": "pipeline",
        "type": "docker",
        "name": "cleanup-%s-%s" % (config["arch"], config["version"]["value"]),
        "platform": {
            "os": "linux",
            "arch": config["platform"],
        },
        "clone": {
            "disable": True,
        },
        "steps": cleanup(config),
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/pull/**",
            ],
            "status": [
                "success",
                "failure",
            ],
        },
    }]

    push = [{
        "kind": "pipeline",
        "type": "docker",
        "name": "publish-%s-%s" % (config["arch"], config["version"]["value"]),
        "platform": {
            "os": "linux",
            "arch": config["platform"],
        },
        "steps": tarball(config) + ldap(config) + richdocuments(config) + onlyoffice(config) + openidconnect(config) + publish(config),
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
            ],
        },
    }]

    test = []

    if config["arch"] == "amd64":
        for step in list(range(1, config["split"] + 1)):
            config["step"] = step

            test.append({
                "kind": "pipeline",
                "type": "docker",
                "name": "api%d-%s-%s" % (config["step"], config["arch"], config["version"]["value"]),
                "platform": {
                    "os": "linux",
                    "arch": config["platform"],
                },
                "clone": {
                    "disable": True,
                },
                "steps": wait(config) + api(config),
                "services": [
                    {
                        "name": "server",
                        "image": "registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
                        "pull": "always",
                        "environment": {
                            "DEBUG": "true",
                            "OWNCLOUD_APPS_INSTALL": "https://github.com/owncloud/testing/releases/download/latest/testing.tar.gz",
                            "OWNCLOUD_APPS_ENABLE": "testing",
                            "OWNCLOUD_REDIS_HOST": "redis",
                            "OWNCLOUD_DB_TYPE": "mysql",
                            "OWNCLOUD_DB_HOST": "mysql",
                            "OWNCLOUD_DB_USERNAME": "owncloud",
                            "OWNCLOUD_DB_PASSWORD": "owncloud",
                            "OWNCLOUD_DB_NAME": "owncloud",
                        },
                    },
                    {
                        "name": "mysql",
                        "image": "library/mysql:5.7",
                        "pull": "always",
                        "environment": {
                            "MYSQL_ROOT_PASSWORD": "owncloud",
                            "MYSQL_USER": "owncloud",
                            "MYSQL_PASSWORD": "owncloud",
                            "MYSQL_DATABASE": "owncloud",
                        },
                    },
                    {
                        "name": "redis",
                        "image": "library/redis:4.0",
                        "pull": "always",
                    },
                ],
                "image_pull_secrets": [
                    "registries",
                ],
                "depends_on": [],
                "trigger": {
                    "ref": [
                        "refs/heads/master",
                        "refs/pull/**",
                    ],
                },
            })

        for step in list(range(1, config["split"] + 1)):
            config["step"] = step

            test.append({
                "kind": "pipeline",
                "type": "docker",
                "name": "ui%d-%s-%s" % (config["step"], config["arch"], config["version"]["value"]),
                "platform": {
                    "os": "linux",
                    "arch": config["platform"],
                },
                "clone": {
                    "disable": True,
                },
                "steps": wait(config) + ui(config),
                "services": [
                    {
                        "name": "server",
                        "image": "registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
                        "pull": "always",
                        "environment": {
                            "DEBUG": "true",
                            "OWNCLOUD_APPS_INSTALL": "https://github.com/owncloud/testing/releases/download/latest/testing.tar.gz",
                            "OWNCLOUD_APPS_ENABLE": "testing",
                            "OWNCLOUD_REDIS_HOST": "redis",
                            "OWNCLOUD_DB_TYPE": "mysql",
                            "OWNCLOUD_DB_HOST": "mysql",
                            "OWNCLOUD_DB_USERNAME": "owncloud",
                            "OWNCLOUD_DB_PASSWORD": "owncloud",
                            "OWNCLOUD_DB_NAME": "owncloud",
                        },
                    },
                    {
                        "name": "mysql",
                        "image": "library/mysql:5.7",
                        "pull": "always",
                        "environment": {
                            "MYSQL_ROOT_PASSWORD": "owncloud",
                            "MYSQL_USER": "owncloud",
                            "MYSQL_PASSWORD": "owncloud",
                            "MYSQL_DATABASE": "owncloud",
                        },
                    },
                    {
                        "name": "redis",
                        "image": "library/redis:4.0",
                        "pull": "always",
                    },
                    {
                        "name": "email",
                        "image": "mailhog/mailhog:latest",
                        "pull": "always",
                    },
                    {
                        "name": "selenium",
                        "image": "selenium/standalone-chrome-debug:3.141.59-oxygen",
                        "pull": "always",
                    },
                ],
                "image_pull_secrets": [
                    "registries",
                ],
                "depends_on": [],
                "trigger": {
                    "ref": [
                        "refs/heads/master",
                        "refs/pull/**",
                    ],
                },
            })
    else:
        test.append({
            "kind": "pipeline",
            "type": "docker",
            "name": "test-%s-%s" % (config["arch"], config["version"]["value"]),
            "platform": {
                "os": "linux",
                "arch": config["platform"],
            },
            "clone": {
                "disable": True,
            },
            "steps": wait(config) + tests(config),
            "services": [
                {
                    "name": "server",
                    "image": "registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
                    "pull": "always",
                    "environment": {
                        "DEBUG": "true",
                        "OWNCLOUD_APPS_INSTALL": "https://github.com/owncloud/testing/releases/download/latest/testing.tar.gz",
                        "OWNCLOUD_APPS_ENABLE": "testing",
                    },
                },
            ],
            "image_pull_secrets": [
                "registries",
            ],
            "depends_on": [],
            "trigger": {
                "ref": [
                    "refs/heads/master",
                    "refs/pull/**",
                ],
            },
        })

    for t in test:
        for p in push:
            p["depends_on"].append(t["name"])

        for p in pre:
            t["depends_on"].append(p["name"])

        for p in post:
            p["depends_on"].append(t["name"])

            for x in push:
                p["depends_on"].append(x["name"])

    return pre + test + push + post

def manifest(config):
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "manifest-%s" % config["version"]["value"],
        "platform": {
            "os": "linux",
            "arch": "amd64",
        },
        "steps": [
            {
                "name": "generate",
                "image": "owncloud/ubuntu:19.10",
                "pull": "always",
                "environment": {
                    "MANIFEST_VERSION": config["version"]["value"],
                    "MANIFEST_TAGS": ",".join(config["version"]["tags"]) if len(config["version"]["tags"]) > 0 else "-",
                },
                "commands": [
                    "gomplate -f %s/manifest.tmpl -o %s/manifest.yml" % (config["version"]["base"], config["version"]["base"]),
                ],
            },
            {
                "name": "manifest",
                "image": "plugins/manifest",
                "pull": "always",
                "settings": {
                    "username": {
                        "from_secret": "public_username",
                    },
                    "password": {
                        "from_secret": "public_password",
                    },
                    "spec": "%s/manifest.yml" % config["version"]["base"],
                    "ignore_missing": "true",
                },
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/tags/**",
            ],
        },
    }

def documentation(config):
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "documentation",
        "platform": {
            "os": "linux",
            "arch": "amd64",
        },
        "steps": [
            {
                "name": "link-check",
                "image": "ghcr.io/tcort/markdown-link-check:stable",
                "commands": [
                    "/src/markdown-link-check README.md",
                ],
            },
            {
                "name": "publish",
                "image": "chko/docker-pushrm:1",
                "environment": {
                    "DOCKER_PASS": {
                        "from_secret": "public_password",
                    },
                    "DOCKER_USER": {
                        "from_secret": "public_username",
                    },
                    "PUSHRM_FILE": "README.md",
                    "PUSHRM_TARGET": "owncloud/${DRONE_REPO_NAME}",
                    "PUSHRM_SHORT": config["description"],
                },
                "when": {
                    "ref": [
                        "refs/heads/master",
                    ],
                },
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/tags/**",
                "refs/pull/**",
            ],
        },
    }

def rocketchat(config):
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "rocketchat",
        "platform": {
            "os": "linux",
            "arch": "amd64",
        },
        "clone": {
            "disable": True,
        },
        "steps": [
            {
                "name": "notify",
                "image": "plugins/slack",
                "pull": "always",
                "failure": "ignore",
                "settings": {
                    "webhook": {
                        "from_secret": "public_rocketchat",
                    },
                    "channel": "docker",
                },
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/tags/**",
            ],
            "status": [
                "changed",
                "failure",
            ],
        },
    }

def tarball(config):
    return [{
        "name": "tarball",
        "image": "plugins/download",
        "pull": "always",
        "settings": {
            "username": {
                "from_secret": "download_username",
            },
            "password": {
                "from_secret": "download_password",
            },
            "source": config["version"]["tarball"],
            "sha256": config["version"]["tarball_sha"],
            "destination": "%s/owncloud.tar.bz2" % config["version"]["base"],
        },
    }]

def ldap(config):
    return [{
        "name": "ldap",
        "image": "plugins/download",
        "pull": "always",
        "settings": {
            "source": config["version"]["ldap"],
            "sha256": config["version"]["ldap_sha"],
            "destination": "%s/user_ldap.tar.gz" % config["version"]["base"],
        },
    }]

def richdocuments(config):
    return [{
        "name": "richdocuments",
        "image": "plugins/download",
        "pull": "always",
        "settings": {
            "source": config["version"]["richdocuments"],
            "sha256": config["version"]["richdocuments_sha"],
            "destination": "%s/richdocuments.tar.gz" % config["version"]["base"],
        },
    }]

def onlyoffice(config):
    return [{
        "name": "onlyoffice",
        "image": "plugins/download",
        "pull": "always",
        "settings": {
            "source": config["version"]["onlyoffice"],
            "sha256": config["version"]["onlyoffice_sha"],
            "destination": "%s/onlyoffice.tar.gz" % config["version"]["base"],
        },
    }]

def openidconnect(config):
    return [{
        "name": "openidconnect",
        "image": "plugins/download",
        "pull": "always",
        "settings": {
            "source": config["version"]["openidconnect"],
            "sha256": config["version"]["openidconnect_sha"],
            "destination": "%s/openidconnect.tar.gz" % config["version"]["base"],
        },
    }]

def prepublish(config):
    return [{
        "name": "prepublish",
        "image": "plugins/docker",
        "pull": "always",
        "settings": {
            "username": {
                "from_secret": "internal_username",
            },
            "password": {
                "from_secret": "internal_password",
            },
            "tags": config["internal"],
            "dockerfile": "%s/Dockerfile.%s" % (config["version"]["base"], config["arch"]),
            "repo": "registry.drone.owncloud.com/owncloud/%s" % config["repo"],
            "registry": "registry.drone.owncloud.com",
            "context": config["version"]["base"],
            "purge": False,
        },
    }]

def sleep(config):
    return [{
        "name": "sleep",
        "image": "owncloudci/alpine:latest",
        "pull": "always",
        "environment": {
            "DOCKER_USER": {
                "from_secret": "internal_username",
            },
            "DOCKER_PASSWORD": {
                "from_secret": "internal_password",
            },
        },
        "commands": [
            "retry -- 'reg digest --username $DOCKER_USER --password $DOCKER_PASSWORD registry.drone.owncloud.com/owncloud/%s:%s'" % (config["repo"], config["internal"]),
        ],
    }]

# container vulnerability scanning, see: https://github.com/aquasecurity/trivy
def trivy(config):
    if config["arch"] != "amd64":
        return []

    return [
        {
            "name": "database",
            "image": "plugins/download",
            "pull": "always",
            "settings": {
                "source": "https://minio.owncloud.com/packages/trivy/trivy.tar.gz",
            },
        },
        {
            "name": "trivy",
            "image": "aquasec/trivy",
            "environment": {
                "TRIVY_AUTH_URL": "https://registry.drone.owncloud.com",
                "TRIVY_USERNAME": {
                    "from_secret": "internal_username",
                },
                "TRIVY_PASSWORD": {
                    "from_secret": "internal_password",
                },
                "TRIVY_NO_PROGRESS": True,
                "TRIVY_IGNORE_UNFIXED": True,
                "TRIVY_TIMEOUT": "5m",
                "TRIVY_EXIT_CODE": "1",
                "TRIVY_SKIP_UPDATE": True,
                "TRIVY_SEVERITY": "HIGH,CRITICAL",
                "TRIVY_CACHE_DIR": "/drone/src/trivy",
            },
            "commands": [
                "tar -xf trivy.tar.gz",
                "trivy image registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
            ],
        },
    ]

def wait(config):
    return [{
        "name": "wait",
        "image": "owncloud/ubuntu:19.10",
        "pull": "always",
        "commands": [
            "wait-for-it -t 600 server:8080",
        ],
    }]

def api(config):
    return [
        {
            "name": "tarball",
            "image": "plugins/download",
            "pull": "always",
            "settings": {
                "username": {
                    "from_secret": "download_username",
                },
                "password": {
                    "from_secret": "download_password",
                },
                "source": config["version"]["qa"],
                "destination": "owncloud-qa.tar.bz2",
            },
        },
        {
            "name": "extract",
            "image": "owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "tar -xjf owncloud-qa.tar.bz2 -C /drone/src --strip 1",
            ],
        },
        {
            "name": "version",
            "image": "owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "cat version.php",
            ],
        },
        {
            "name": "behat",
            "image": "owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "mkdir -p vendor-bin/behat",
                "wget -O vendor-bin/behat/composer.json https://raw.githubusercontent.com/owncloud/core/%s/vendor-bin/behat/composer.json" % versionize(config["version"]),
                "cd vendor-bin/behat/ && composer install",
            ],
        },
        {
            "name": "tests",
            "image": "owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "environment": {
                "TEST_SERVER_URL": "http://server:8080",
                "SKELETON_DIR": "/mnt/data/apps/testing/data/apiSkeleton",
            },
            "commands": [
                'bash tests/acceptance/run.sh --remote --tags "@smokeTest&&~@skip&&~@skipOnDockerContainerTesting" --type api --part %d %d' % (config["step"], config["split"]),
            ],
        },
    ]

def ui(config):
    return [
        {
            "name": "tarball",
            "image": "plugins/download",
            "pull": "always",
            "settings": {
                "username": {
                    "from_secret": "download_username",
                },
                "password": {
                    "from_secret": "download_password",
                },
                "source": config["version"]["qa"],
                "destination": "owncloud-qa.tar.bz2",
            },
        },
        {
            "name": "extract",
            "image": "owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "tar -xjf owncloud-qa.tar.bz2 -C /drone/src --strip 1",
            ],
        },
        {
            "name": "version",
            "image": "owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "cat version.php",
            ],
        },
        {
            "name": "behat",
            "image": "owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "mkdir -p vendor-bin/behat",
                "wget -O vendor-bin/behat/composer.json https://raw.githubusercontent.com/owncloud/core/%s/vendor-bin/behat/composer.json" % versionize(config["version"]),
                "cd vendor-bin/behat/ && composer install",
            ],
        },
        {
            "name": "tests",
            "image": "owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "environment": {
                "TEST_SERVER_URL": "http://server:8080",
                "SKELETON_DIR": "/mnt/data/apps/testing/data/webUISkeleton",
                "BROWSER": "chrome",
                "SELENIUM_HOST": "selenium",
                "SELENIUM_PORT": "4444",
                "PLATFORM": "Linux",
                "MAILHOG_HOST": "email",
                "LOCAL_MAILHOG_HOST": "email",
            },
            "commands": [
                'bash tests/acceptance/run.sh --remote --tags "@smokeTest&&~@skip&&~@skipOnDockerContainerTesting" --type webUI --part %d %d' % (config["step"], config["split"]),
            ],
        },
    ]

def tests(config):
    return [{
        "name": "test",
        "image": "owncloud/ubuntu:19.10",
        "pull": "always",
        "commands": [
            "curl -sSf http://server:8080/status.php",
        ],
    }]

def publish(config):
    return [{
        "name": "publish",
        "image": "plugins/docker",
        "pull": "always",
        "settings": {
            "username": {
                "from_secret": "public_username",
            },
            "password": {
                "from_secret": "public_password",
            },
            "tags": config["tag"],
            "dockerfile": "%s/Dockerfile.%s" % (config["version"]["base"], config["arch"]),
            "repo": "owncloud/%s" % config["repo"],
            "context": config["version"]["base"],
            "cache_from": "registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
            "pull_image": False,
        },
        "when": {
            "ref": [
                "refs/heads/master",
            ],
        },
    }]

def cleanup(config):
    return [{
        "name": "cleanup",
        "image": "owncloudci/alpine:latest",
        "pull": "always",
        "failure": "ignore",
        "environment": {
            "DOCKER_USER": {
                "from_secret": "internal_username",
            },
            "DOCKER_PASSWORD": {
                "from_secret": "internal_password",
            },
        },
        "commands": [
            "reg rm --username $DOCKER_USER --password $DOCKER_PASSWORD registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
        ],
    }]

def checkStarlark():
    return {
        "kind": "pipeline",
        "type": "docker",
        "name": "check-starlark",
        "steps": [
            {
                "name": "format-check-starlark",
                "image": "owncloudci/bazel-buildifier",
                "pull": "always",
                "commands": [
                    "buildifier --mode=check .drone.star",
                ],
            },
            {
                "name": "show-diff",
                "image": "owncloudci/bazel-buildifier",
                "pull": "always",
                "commands": [
                    "buildifier --mode=fix .drone.star",
                    "git diff",
                ],
                "when": {
                    "status": [
                        "failure",
                    ],
                },
            },
        ],
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
                "refs/pull/**",
            ],
        },
    }

def versionize(version):
    if "behat_version" in version:
        return version["behat_version"]
    else:
        return "v%s" % (version["value"].replace("rc", "RC").replace("-", ""))
