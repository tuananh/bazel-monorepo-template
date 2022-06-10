load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")
load("@io_bazel_rules_docker//go:image.bzl", "go_image")

go_library(
    name = "go_lib",
    srcs = ["main.go"],
    importpath = "github.com/tuananh/bazel-monorepo-template/go",
    visibility = ["//visibility:private"],
    deps = ["@com_github_urfave_cli_v2//:go_default_library"],
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
        "@com_github_urfave_cli_v2//:go_default_library",
    ],
)
