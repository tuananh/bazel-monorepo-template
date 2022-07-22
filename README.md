# Bazel Monorepo Template

## Goals

- Production-ready monorepo template with
    - GitHub Actions for CI
    - Bazel cache
    - Linting
    - Dependencies management

## Requirements

- Install the following tools
    - `bazelisk`: a bazel launcher. bazelisk will respect `.bazelrc` and `.bazelversion` settings.
    - `docker`: if you want to launch a local remote cache using `buchgr/bazel-remote-cache`.`
    
## Managing dependencies

### Golang

We use `gazelle` to manage go dependencies. When you update `go.mod`, do `bz run //:gazelle-update-repos` to update [`3rdparty/go_workspace.bzl`](/3rdparty/go_workspace.bzl).

The way it works is configured here in [`BUILD`](/BUILD) so tweak it if you need. `gazelle` use `go.mod` file via `-from_file` param, output to `go_dependencies()` section in `3rdparty/go_workspace.bzl` file. Then we load to [`WORKSPACE`](/WORKSPACE) by this

```
load("//3rdparty:go_workspace.bzl", "go_dependencies")

# gazelle:repository_macro 3rdparty/go_workspace.bzl%go_dependencies
go_dependencies()
```

```starlark
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
```

### Java

- `rules_jvm_external` is used for java. The script is wrapped in [`hack/dependencies/jvm_dependencies.yaml`](hack/dependencies/jvm_dependencies.yaml)

### Python

- For Python, it's in [`3rdparty/requirements.in`](/3rdparty/requirements.in) and run `bazel run //3rdparty:requirements.update`.

## Supported languages/stack

- [x] Java
- [x] Golang
- [ ] Python
- [ ] JavaScript/TypeScript
- [x] Building container image for each of the service

## Build

```shell
# build go & java service container image
make go-image
make java-image

# show help
make help
```

## Contributing

## License

Copyright 2022 Tuan Anh Tran <me@tuananh.org>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.