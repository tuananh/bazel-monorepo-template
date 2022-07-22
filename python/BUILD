load("@rules_python//python:defs.bzl", "py_binary")
load("@rules_python//python/pip_install:repositories.bzl", "requirement")

py_binary(
    name = "main",
    srcs = ["main.py"],
    deps = [
        requirement("Flask"),
    ],
)
