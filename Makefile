BAZEL           = bazelisk

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

.PHONY: clean
clean: ## doing bazel clean
	$(BAZEL) clean --expunge

.PHONY: build
build: ## build everything
	$(BAZEL) build //...

.PHONY: ensure-go-dep
ensure-go-dep: ## update go dependencies
	$(BAZEL) run //:gazelle-update-repos

.PHONY: ensure-java-dep
ensure-java-dep: ## update jvm dependencies
	./hack/update_jvm_dependencies.sh

.PHONY: lint
lint: ## linting and shit
	./hack/linting/lint.sh

.PHONY: start-cache-dev
start-cache-dev: ## start a bazel cache server
	mkdir -p /tmp/bazel-remote-cache/
	docker run -u 1000:1000 \
		-v /tmp/bazel-remote-cache/:/data \
		-p 9090:8080 \
		-p 9092:9092 \
		buchgr/bazel-remote-cache