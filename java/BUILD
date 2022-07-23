load("@io_bazel_rules_docker//java:image.bzl", "java_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_push")

java_image(
    name = "image",
    main_class = "com.bookstore.layoutsolver.StoreLayoutSolver",
    runtime_deps = [],
)

container_push(
    name = "push_image",
    format = "OCI",
    image = ":image",
    registry = "docker.io",
    repository = "tuananhorg/java_example",
    tag = "dev",
)
