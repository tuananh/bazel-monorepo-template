load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@io_bazel_rules_docker//go:image.bzl", "go_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_push")

go_library(
    name = "go_lib",
    srcs = ["main.go"],
    importpath = "github.com/tuananh/bazel-monorepo-template/go",
    visibility = ["//visibility:private"],
    deps = ["@com_github_gin_gonic_gin//:go_default_library"],
)

go_binary(
    name = "go",
    embed = [":go_lib"],
    visibility = ["//visibility:public"],
)

go_image(
    name = "image",
    srcs = ["main.go"],
    visibility = ["//visibility:public"],
    deps = [
        "@com_github_gin_gonic_gin//:go_default_library",
    ],
)

container_push(
    name = "push_image",
    image = ":image",
    format = "OCI",
    registry = "docker.io",
    repository = "tuananhorg/go_example",
    tag = "dev",
)