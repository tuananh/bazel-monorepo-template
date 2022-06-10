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
    - `docker`: if you want to launch a local remote cache using `buchgr/bazel-remote-cache`.
    
## Managing dependencies

### Golang

We use `gazelle` to manage go dependencies. When you update `go.mod`, do `bz run //:gazelle-update-repos` to update [`3rdparty/go_workspace.bzl`](/3rdparty/go_workspace.bzl).

### Java

- `rules_jvm_external` is used for java. The script is wrapped in [`tools/dependencies/jvm_dependencies.yaml`](tools/dependencies/jvm_dependencies.yaml)

### Python

- For Python, it's in [`3rdparty/requirements.in`](/3rdparty/requirements.in) and run `bazel run //3rdparty:requirements.update`.

## Supported languages/stack

- [x] Java
- [x] Golang
- Python
- JavaScript/TypeScript
- [x] Building container image

## Build

```shell
make build
```

## Test

```shell
make test
```

## Contributing

## License

Copyright 2022 Tuan Anh Tran <me@tuananh.org>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.