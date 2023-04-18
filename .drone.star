def main(ctx):
    versions = [
        {
            "value": "10.12.1",
            "tarball": "https://download.owncloud.com/server/stable/owncloud-complete-20230415.tar.bz2",
            "tarball_sha": "4db0e834b3df661370679759f7556013d18d6e4de30a70ff30d70f89d5f25794",
            "ldap": "https://github.com/owncloud/user_ldap/releases/download/v0.17.0/user_ldap-0.17.0.tar.gz",
            "ldap_sha": "d1e0eeb010b887ac709b3adf52e0302cd442149dd83041333c837cdc3d2dbe91",
            "openidconnect": "https://marketplace.owncloud.com/api/v1/apps/openidconnect/2.2.0",
            "openidconnect_sha": "10f02276c3f1e93f5150e3aa06e8041237d1ffe20ad85a0cedeb8579e6620d77",
            "onlyoffice": "https://marketplace.owncloud.com/api/v1/apps/onlyoffice/7.8.1",
            "onlyoffice_sha": "15135dfdf7c7d04fc28e8c82d47a9da9749bf9b00595986239babe2fc274fb19",
            "richdocuments": "https://marketplace.owncloud.com/api/v1/apps/richdocuments/3.0.0",
            "richdocuments_sha": "7d583b8679f60e65ed3cc6eafc485c40eec1ab73990e55dc62a06ef744f1c954",
            "php": "7.4",
            "base": "v20.04",
            "tags": ["10.12", "10", "latest"],
        },
        {
            "value": "10.11.0",
            "tarball": "https://download.owncloud.com/server/stable/owncloud-complete-20220919.tar.bz2",
            "tarball_sha": "8cbd911da3a77d9af3e746080bb8e4e74f4bb4c34147231c01cc0c7b8f72417f",
            "ldap": "https://github.com/owncloud/user_ldap/releases/download/v0.16.0/user_ldap-0.16.0.tar.gz",
            "ldap_sha": "91ac533b4b6e0d6647c01ac4846b62c00c643cb9554be2a378209de5a0538555",
            "openidconnect": "https://marketplace.owncloud.com/api/v1/apps/openidconnect/2.1.1",
            "openidconnect_sha": "526dfb612ed79b62e0d2bc9cb577a82d128439c5083b1197c3e2d9301e257856",
            "onlyoffice": "https://marketplace.owncloud.com/api/v1/apps/onlyoffice/7.3.3",
            "onlyoffice_sha": "2809a2ca5b6d6c9e58a353e0de19bf6b626114da65ad825af16d1fa5c29e1784",
            "richdocuments": "https://marketplace.owncloud.com/api/v1/apps/richdocuments/2.7.0",
            "richdocuments_sha": "dc14f464e27d7a6e524dea394961991d6bed3d2176fb50825192008b63438fa5",
            "php": "7.4",
            "base": "v20.04",
            "tags": ["10.11"],
        },
    ]

    arches = [
        "amd64",
    ]

    config = {
        "version": None,
        "arch": None,
        "splitAPI": 10,
        "splitUI": 5,
        "description": "ownCloud image for the Univention appliance",
        "repo": ctx.repo.name,
    }

    stages = []
    shell = []
    shell_bases = []

    for version in versions:
        config["version"] = version

        m = manifest(config)

        if config["version"]["base"] not in shell_bases:
            shell_bases.append(config["version"]["base"])
            shell.extend(shellcheck(config))

        config["version"]["qa"] = config["version"].get("qa", "https://download.owncloud.com/server/daily/owncloud-daily-master-qa.tar.bz2")
        config["version"]["behat"] = config["version"].get("behat", "https://raw.githubusercontent.com/owncloud/core/master/vendor-bin/behat/composer.json")

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

            config["internal"] = "%s-%s-%s" % (ctx.build.commit, "${DRONE_BUILD_NUMBER}", config["tag"])

            for d in docker(config):
                d["depends_on"].append(lint(shell)["name"])
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

    return [lint(shell)] + stages + after

def docker(config):
    pre = [{
        "kind": "pipeline",
        "type": "docker",
        "name": "prepublish-%s-%s" % (config["arch"], config["version"]["value"]),
        "platform": {
            "os": "linux",
            "arch": config["platform"],
        },
        "steps": download(config) + ldap(config) + richdocuments(config) + onlyoffice(config) + openidconnect(config) + prepublish(config) + sleep(config) + trivy(config),
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
        "steps": download(config) + ldap(config) + richdocuments(config) + onlyoffice(config) + openidconnect(config) + publish(config),
        "depends_on": [],
        "trigger": {
            "ref": [
                "refs/heads/master",
            ],
        },
    }]

    test = []

    if config["arch"] == "amd64":
        for step in list(range(1, config["splitAPI"] + 1)):
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
                "steps": wait_server(config) + api(config),
                "services": [
                    {
                        "name": "server",
                        "image": "registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
                        "environment": {
                            "DEBUG": "true",
                            "OWNCLOUD_TRUSTED_DOMAINS": "server",
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
                        "image": "docker.io/mariadb:10.6",
                        "environment": {
                            "MYSQL_ROOT_PASSWORD": "owncloud",
                            "MYSQL_USER": "owncloud",
                            "MYSQL_PASSWORD": "owncloud",
                            "MYSQL_DATABASE": "owncloud",
                        },
                    },
                    {
                        "name": "redis",
                        "image": "docker.io/redis:6",
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

        for step in list(range(1, config["splitUI"] + 1)):
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
                "steps": wait_server(config) + wait_email(config) + ui(config),
                "services": [
                    {
                        "name": "server",
                        "image": "registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
                        "environment": {
                            "DEBUG": "true",
                            "OWNCLOUD_TRUSTED_DOMAINS": "server",
                            "OWNCLOUD_APPS_INSTALL": "https://github.com/owncloud/testing/releases/download/latest/testing.tar.gz",
                            "OWNCLOUD_APPS_ENABLE": "testing",
                            "OWNCLOUD_INTEGRITY_CHECK_DISABLED": "true",
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
                        "image": "docker.io/mariadb:10.6",
                        "environment": {
                            "MYSQL_ROOT_PASSWORD": "owncloud",
                            "MYSQL_USER": "owncloud",
                            "MYSQL_PASSWORD": "owncloud",
                            "MYSQL_DATABASE": "owncloud",
                        },
                    },
                    {
                        "name": "redis",
                        "image": "docker.io/redis:6",
                    },
                    {
                        "name": "email",
                        "image": "docker.io/inbucket/inbucket",
                    },
                    {
                        "name": "selenium",
                        "image": "docker.io/selenium/standalone-chrome:111.0",
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
            "steps": wait_server(config) + tests(config),
            "services": [
                {
                    "name": "server",
                    "image": "registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
                    "pull": "always",
                    "environment": {
                        "DEBUG": "true",
                        "OWNCLOUD_TRUSTED_DOMAINS": "server",
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
                "image": "docker.io/owncloud/ubuntu:20.04",
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
                "image": "docker.io/plugins/manifest",
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
                "image": "ghcr.io/tcort/markdown-link-check:3.11.0",
                "commands": [
                    "/src/markdown-link-check README.md",
                ],
            },
            {
                "name": "publish",
                "image": "docker.io/chko/docker-pushrm:1",
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
                "image": "docker.io/plugins/slack",
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

def download(config):
    return [{
        "name": "download",
        "image": "docker.io/plugins/download",
        "settings": {
            "source": config["version"]["tarball"],
            "sha256": config["version"]["tarball_sha"],
            "destination": "%s/owncloud.tar.bz2" % config["version"]["base"],
        },
    }]

def ldap(config):
    return [{
        "name": "ldap",
        "image": "docker.io/plugins/download",
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
        "image": "docker.io/plugins/download",
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
        "image": "docker.io/plugins/download",
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
        "image": "docker.io/plugins/download",
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
        "image": "docker.io/plugins/docker",
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
        "image": "docker.io/owncloudci/alpine",
        "environment": {
            "DOCKER_USER": {
                "from_secret": "internal_username",
            },
            "DOCKER_PASSWORD": {
                "from_secret": "internal_password",
            },
        },
        "commands": [
            "regctl registry login registry.drone.owncloud.com --user $DOCKER_USER --pass $DOCKER_PASSWORD",
            "retry -- 'regctl image digest registry.drone.owncloud.com/owncloud/%s:%s'" % (config["repo"], config["internal"]),
        ],
    }]

# container vulnerability scanning, see: https://github.com/aquasecurity/trivy
def trivy(config):
    if config["arch"] != "amd64":
        return []

    return [
        {
            "name": "trivy-presets",
            "image": "docker.io/owncloudci/alpine",
            "commands": [
                'retry -t 3 -s 5 -- "curl -sSfL https://github.com/owncloud-docker/trivy-presets/archive/refs/heads/main.tar.gz | tar xz --strip-components=2 trivy-presets-main/base/"',
            ],
        },
        {
            "name": "trivy-db",
            "image": "docker.io/plugins/download",
            "settings": {
                "source": {
                    "from_secret": "trivy_db_download_url",
                },
            },
        },
        {
            "name": "trivy-scan",
            "image": "ghcr.io/aquasecurity/trivy",
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
                "TRIVY_DB_SKIP_UPDATE": True,
                "TRIVY_SEVERITY": "HIGH,CRITICAL",
                "TRIVY_CACHE_DIR": "/drone/src/trivy",
            },
            "commands": [
                "tar -xf trivy.tar.gz",
                "trivy -v",
                "trivy image registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
            ],
        },
    ]

def wait_server(config):
    return [{
        "name": "wait-server",
        "image": "docker.io/owncloud/ubuntu:20.04",
        "pull": "always",
        "commands": [
            "wait-for-it -t 600 server:8080",
        ],
    }]

def wait_email(config):
    return [{
        "name": "wait-email",
        "image": "docker.io/owncloud/ubuntu:20.04",
        "commands": [
            "wait-for-it -t 600 email:9000",
        ],
    }]

def api(config):
    return [
        {
            "name": "api-tarball",
            "image": "docker.io/plugins/download",
            "pull": "always",
            "settings": {
                "source": config["version"]["qa"],
                "destination": "owncloud-qa.tar.bz2",
            },
        },
        {
            "name": "extract",
            "image": "docker.io/owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "tar -xjf owncloud-qa.tar.bz2 -C /drone/src --strip 1",
            ],
        },
        {
            "name": "version",
            "image": "docker.io/owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "cat version.php",
            ],
        },
        {
            "name": "behat",
            "image": "docker.io/owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "mkdir -p vendor-bin/behat",
                "wget -O vendor-bin/behat/composer.json %s" % config["version"]["behat"],
                "cd vendor-bin/behat/ && composer install",
            ],
        },
        {
            "name": "tests",
            "image": "docker.io/owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "environment": {
                "TEST_SERVER_URL": "http://server:8080",
                "SKELETON_DIR": "/mnt/data/apps/testing/data/apiSkeleton",
            },
            "commands": [
                'bash tests/acceptance/run.sh --remote --tags "@smokeTest&&~@skip&&~@skipOnDockerContainerTesting%s" --type api --part %d %d' % (extraTestFilterTags(config), config["step"], config["splitAPI"]),
            ],
        },
    ]

def ui(config):
    return [
        {
            "name": "ui-tarball",
            "image": "docker.io/plugins/download",
            "pull": "always",
            "settings": {
                "source": config["version"]["qa"],
                "destination": "owncloud-qa.tar.bz2",
            },
        },
        {
            "name": "extract",
            "image": "docker.io/owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "tar -xjf owncloud-qa.tar.bz2 -C /drone/src --strip 1",
            ],
        },
        {
            "name": "version",
            "image": "docker.io/owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "cat version.php",
            ],
        },
        {
            "name": "behat",
            "image": "docker.io/owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "commands": [
                "mkdir -p vendor-bin/behat",
                "wget -O vendor-bin/behat/composer.json %s" % config["version"]["behat"],
                "cd vendor-bin/behat/ && composer install",
            ],
        },
        {
            "name": "tests",
            "image": "docker.io/owncloudci/php:%s" % config["version"]["php"],
            "pull": "always",
            "environment": {
                "TEST_SERVER_URL": "http://server:8080",
                "SKELETON_DIR": "/mnt/data/apps/testing/data/webUISkeleton",
                "BROWSER": "chrome",
                "SELENIUM_HOST": "selenium",
                "SELENIUM_PORT": "4444",
                "PLATFORM": "Linux",
                "EMAIL_HOST": "email",
                "LOCAL_EMAIL_HOST": "email",
            },
            "commands": [
                'bash tests/acceptance/run.sh --remote --tags "@smokeTest&&~@skip&&~@skipOnDockerContainerTesting%s" --type webUI --part %d %d' % (extraTestFilterTags(config), config["step"], config["splitUI"]),
            ],
        },
    ]

def tests(config):
    return [{
        "name": "test",
        "image": "docker.io/owncloud/ubuntu:20.04",
        "commands": [
            "curl -sSf http://server:8080/status.php",
        ],
    }]

def publish(config):
    return [{
        "name": "publish",
        "image": "docker.io/plugins/docker",
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
        "image": "docker.io/owncloudci/alpine",
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
            "regctl registry login registry.drone.owncloud.com --user $DOCKER_USER --pass $DOCKER_PASSWORD",
            "regctl tag rm registry.drone.owncloud.com/owncloud/%s:%s" % (config["repo"], config["internal"]),
        ],
    }]

def lint(shell):
    lint = {
        "kind": "pipeline",
        "type": "docker",
        "name": "lint",
        "steps": [
            {
                "name": "starlark-format",
                "image": "docker.io/owncloudci/bazel-buildifier",
                "commands": [
                    "buildifier --mode=check .drone.star",
                ],
            },
            {
                "name": "starlark-diff",
                "image": "docker.io/owncloudci/bazel-buildifier",
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

    lint["steps"].extend(shell)

    return lint

def shellcheck(config):
    return [
        {
            "name": "shellcheck-%s" % (config["version"]["base"]),
            "image": "docker.io/koalaman/shellcheck-alpine:stable",
            "commands": [
                "grep -ErlI '^#!(.*/|.*env +)(sh|bash|ksh)' %s/overlay/ | xargs -r shellcheck" % (config["version"]["base"]),
            ],
        },
    ]

def extraTestFilterTags(config):
    if "version" not in config:
        return ""

    if "extraTestFilterTags" not in config["version"]:
        return ""

    if (config["version"]["extraTestFilterTags"] == ""):
        return ""
    else:
        return "&&%s" % config["version"]["extraTestFilterTags"]
