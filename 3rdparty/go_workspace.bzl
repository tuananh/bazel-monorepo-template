load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_dependencies():
    go_repository(
        name = "com_github_urfave_cli_v2",
        importpath = "github.com/urfave/cli",
        tag = "v2.8.1",
    )

    go_repository(
        name = "com_github_xrash_smetrics",
        importpath = "github.com/xrash/smetrics",
        commit = "039620a656736e6ad994090895784a7af15e0b80"
    )

    go_repository(
        name = "com_github_cpuguy83_go_md2man_v2",
        importpath = "github.com/cpuguy83/go-md2man",
        tag = "v2.0.1",
    )
