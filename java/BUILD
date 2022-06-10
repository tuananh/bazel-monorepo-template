load("@io_bazel_rules_docker//java:image.bzl", "java_image")
load("@io_bazel_rules_docker//docker:docker.bzl", "docker_push")

DOCKER_REGISTRY_URL = "docker.io"

java_image(
    name = "image",
    main_class = "com.bookstore.layoutsolver.StoreLayoutSolver",
    runtime_deps = [],
)

docker_push(
    name = "push_image",
    image = ":image",
    registry = DOCKER_REGISTRY_URL,
    repository = "tuananhorg/java_example",
    stamp = "never",
    tag = "{BUILD_TIMESTAMP}",
)
