load("@rules_python//python:defs.bzl", "py_binary")
load("@io_bazel_rules_docker//python:image.bzl", "py_image")
load("@python_deps//:requirements.bzl", "requirement")

py_binary(
    name = "main",
    srcs = ["main.py"],
    deps = [
        requirement("Flask"),
    ],
)

py_image(
    name = "image",
    srcs = ["main.py"],
    deps = [
        requirement("Flask"),
    ],
    main = "main.py",
)