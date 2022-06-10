load("@com_github_bazelbuild_buildtools//buildifier:def.bzl", "buildifier")
load("@bazel_gazelle//:def.bzl", "gazelle")

buildifier(name = "buildifier")

# USAGE: bz run //:gazelle
gazelle(
    name = "gazelle",
    prefix = "github.com/tuananh/bazel-monorepo-template",
)

# bz run //:gazelle-update-repos
gazelle(
    name = "gazelle-update-repos",
    args = [
        "-from_file=go/go.mod",
        "-to_macro=3rdparty/go_workspace.bzl%go_dependencies",
        "-prune",
    ],
    command = "update-repos",
)
