BAZEL           = bazelisk

clean:
	$(BAZEL) clean --expunge

.PHONY: build
# build: gazelle
build:
	$(BAZEL) build //...

ensure-go-dep:
	$(BAZEL) run //:gazelle -- update-repos -from_file=go.mod -to_macro=deps.bzl%go_dependencies

ensure-java-dep:
	./hack/update_jvm_dependencies.sh

lint:
	./hack/linting/lint.sh

start-cache-dev:
	mkdir -p /tmp/bazel-remote-cache/
	docker run -u 1000:1000 \
		-v /tmp/bazel-remote-cache/:/data \
		-p 9090:8080 \
		-p 9092:9092 \
		buchgr/bazel-remote-cache