OTELCOL_BUILDER_VERSION ?= 0.2.0
OTELCOL_BUILDER_DIR ?= ~/bin
OTELCOL_BUILDER ?= $(OTELCOL_BUILDER_DIR)/opentelemetry-collector-builder

build: build-agent build-collector

build-agent: otelcol-builder
	@$(OTELCOL_BUILDER) --config agent/agent-manifest.yaml

build-collector: otelcol-builder
	@$(OTELCOL_BUILDER) --config collector/collector-manifest.yaml

otelcol-builder:
ifeq (, $(shell which opentelemetry-collector-builder))
	@{ \
	set -e ;\
	mkdir -p $(OTELCOL_BUILDER_DIR) ;\
	curl -sLo $(OTELCOL_BUILDER) https://github.com/observatorium/opentelemetry-collector-builder/releases/download/v$(OTELCOL_BUILDER_VERSION)/opentelemetry-collector-builder_$(OTELCOL_BUILDER_VERSION)_linux_x86_64 ;\
	chmod +x $(OTELCOL_BUILDER) ;\
	}
else
OTELCOL_BUILDER=$(shell which opentelemetry-collector-builder)
endif
