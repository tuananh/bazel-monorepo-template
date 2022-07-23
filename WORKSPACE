workspace(name = "bazel-monorepo-example")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

########### GOLANG SUPPORT ###########

rules_go_version = "v0.33.0"

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "685052b498b6ddfe562ca7a97736741d87916fe536623afb7da2824c0211c369",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/{version}/rules_go-{version}.zip".format(version = rules_go_version),
        "https://github.com/bazelbuild/rules_go/releases/download/{version}/rules_go-{version}.tar.gz".format(version = rules_go_version),
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.18.3")

gazelle_version = "v0.23.0"

# Gazelle - used for Golang external dependencies
http_archive(
    name = "bazel_gazelle",
    sha256 = "62ca106be173579c0a167deb23358fdfe71ffa1e4cfdddf5582af26520f1c66f",
    urls = [
        "https://storage.googleapis.com/bazel-mirror/github.com/bazelbuild/bazel-gazelle/releases/download/{version}/bazel-gazelle-{version}.tar.gz".format(version = gazelle_version),
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/{version}/bazel-gazelle-{version}.tar.gz".format(version = gazelle_version),
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("//3rdparty:go_workspace.bzl", "go_dependencies")

# gazelle:repository_macro 3rdparty/go_workspace.bzl%go_dependencies
go_dependencies()

gazelle_dependencies()

########### JAVA SUPPORT ###########

rules_jvm_external_version = "4.2"

http_archive(
    name = "rules_jvm_external",
    sha256 = "2cd77de091e5376afaf9cc391c15f093ebd0105192373b334f0a855d89092ad5",
    strip_prefix = "rules_jvm_external-{version}".format(version = rules_jvm_external_version),
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/{version}.tar.gz".format(version = rules_jvm_external_version),
)

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    name = "maven",
    artifacts = [
        "com.google.guava:guava:27.1-jre",
        "junit:junit:4.12",
        "org.hamcrest:hamcrest-library:1.3",
        "org.postgresql:postgresql:42.2.10",
        "org.springframework.boot:spring-boot-autoconfigure:2.1.3.RELEASE",
        "org.springframework.boot:spring-boot-loader:2.1.3.RELEASE",
        "org.springframework.boot:spring-boot-test-autoconfigure:2.1.3.RELEASE",
        "org.springframework.boot:spring-boot-test:2.1.3.RELEASE",
        "org.springframework.boot:spring-boot:2.1.3.RELEASE",
        "org.springframework.boot:spring-boot-starter-web:2.1.3.RELEASE",
        "org.springframework.boot:spring-boot-starter-data-jpa:2.1.3.RELEASE",
        "org.springframework:spring-beans:5.1.5.RELEASE",
        "org.springframework:spring-context:5.1.5.RELEASE",
        "org.springframework:spring-test:5.1.5.RELEASE",
        "org.springframework:spring-web:5.1.5.RELEASE",
        "org.springframework:spring-webmvc:5.1.5.RELEASE",
    ],
    fetch_sources = True,  # Fetch source jars. Defaults to False.
    maven_install_json = "@bazel-monorepo-example//3rdparty:maven_install.json",
    repositories = [
        "https://repo1.maven.org/maven2",
        "https://maven.google.com",
    ],
)

load("@maven//:defs.bzl", "pinned_maven_install")

pinned_maven_install()

########### SCALA SUPPORT ###########

rules_scala_version = "c9cc7c261d3d740eb91ef8ef048b7cd2229d12ec"  # Latest at 2021/05/23

http_archive(
    name = "io_bazel_rules_scala",
    sha256 = "a09a6fa6d68174d904fe44a7bcfdcf4572862e65e673b933a9276b4846529a38",
    strip_prefix = "rules_scala-%s" % rules_scala_version,
    url = "https://github.com/bazelbuild/rules_scala/archive/%s.tar.gz" % rules_scala_version,
)

# Stores Scala version and other configuration
# 2.12 is a default version, other versions can be use by passing them explicitly:
# scala_config(scala_version = "2.11.12")
load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")

scala_config()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

# optional: setup ScalaTest toolchain and dependencies
load("@io_bazel_rules_scala//testing:scalatest.bzl", "scalatest_repositories", "scalatest_toolchain")

scalatest_repositories()

scalatest_toolchain()

# Load dependencies managed by bazel-deps
load("//3rdparty:jvm_workspace.bzl", scala_deps = "maven_dependencies")
load("//3rdparty:target_file.bzl", "build_external_workspace")

build_external_workspace(name = "3rdparty_jvm")

scala_deps()

########### PYTHON SUPPORT ###########

rules_python_version = "0.9.0"

http_archive(
    name = "rules_python",
    sha256 = "5fa3c738d33acca3b97622a13a741129f67ef43f5fdfcec63b29374cc0574c29",
    strip_prefix = "rules_python-{}".format(rules_python_version),
    url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/{}.tar.gz".format(rules_python_version),
)

load("@rules_python//python:repositories.bzl", "python_register_toolchains")
python_register_toolchains(
    name = "python3_10",
    python_version = "3.10",
)

load("@python3_10//:defs.bzl", python_interpreter = "interpreter")
load("@rules_python//python:pip.bzl", "pip_install")

pip_install(
    name = "py_deps",
    python_interpreter_target = python_interpreter,
    requirements = "//3rdparty:requirements.txt",
)

# # MYPY SUPPORT
# mypy_integration_version = "0.2.0"  # Latest @ 26th June 2021

# http_archive(
#     name = "mypy_integration",
#     sha256 = "621df076709dc72809add1f5fe187b213fee5f9b92e39eb33851ab13487bd67d",
#     strip_prefix = "bazel-mypy-integration-{version}".format(version = mypy_integration_version),
#     urls = [
#         "https://github.com/thundergolfer/bazel-mypy-integration/archive/refs/tags/{version}.tar.gz".format(version = mypy_integration_version),
#     ],
# )

# load(
#     "@mypy_integration//repositories:repositories.bzl",
#     mypy_integration_repositories = "repositories",
# )

# mypy_integration_repositories()

# load("@mypy_integration//:config.bzl", "mypy_configuration")

# mypy_configuration("//tools/typing:mypy.ini")

# load("@mypy_integration//repositories:deps.bzl", mypy_integration_deps = "deps")

# mypy_integration_deps(
#     "//tools/typing:mypy_version.txt",
#     python_interpreter_target = python_interpreter,
# )

########### TYPESCRIPT / NODEJS SUPPORT ###########

# rules_nodejs_version = "1.7.0"

# http_archive(
#     name = "build_bazel_rules_nodejs",
#     sha256 = "84abf7ac4234a70924628baa9a73a5a5cbad944c4358cf9abdb4aab29c9a5b77",
#     urls = [
#         "https://github.com/bazelbuild/rules_nodejs/releases/download/{version}/rules_nodejs-{version}.tar.gz".format(
#             version = rules_nodejs_version,
#         ),
#     ],
# )

# load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

# yarn_install(
#     name = "npm",
#     package_json = "//3rdparty/typescript:package.json",
#     yarn_lock = "//3rdparty/typescript:yarn.lock",
# )

# load("@npm//:install_bazel_dependencies.bzl", "install_bazel_dependencies")

# install_bazel_dependencies()

########### DOCKER SUPPORT ###########

rules_docker_version = "0.24.0"

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "27d53c1d646fc9537a70427ad7b034734d08a9c38924cc6357cc973fed300820",
    strip_prefix = "rules_docker-{}".format(rules_docker_version),
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v{0}/rules_docker-v{0}.tar.gz".format(rules_docker_version)],
)

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_docker//java:image.bzl", _java_image_repos = "repositories")

_java_image_repos()

load("@io_bazel_rules_docker//go:image.bzl", _go_image_repos = "repositories")

_go_image_repos()

load("@io_bazel_rules_docker//python3:image.bzl", _py_image_repos = "repositories")

_py_image_repos()

# buildifier BUILD file linter
http_archive(
    name = "com_github_bazelbuild_buildtools",
    strip_prefix = "buildtools-master",
    url = "https://github.com/bazelbuild/buildtools/archive/master.tar.gz",
)

# Source code linting system
linting_system_version = "68b6602cc27dec19e1085609b30ab9a0dafa42e2"

http_archive(
    name = "linting_system",
    sha256 = "1b478e73ab5482351d88e03b4b99b44c1db42e069b6e60bdb39c88f66a59cc92",
    strip_prefix = "bazel-linting-system-{version}".format(version = linting_system_version),
    url = "https://github.com/thundergolfer/bazel-linting-system/archive/{version}.tar.gz".format(version = linting_system_version),
)

load("@linting_system//repositories:repositories.bzl", "repositories")
load("@linting_system//repositories:go_repositories.bzl", "go_deps")

repositories()

go_deps()
