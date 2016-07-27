BINARY = s3-get-presigned-url

OUT = $(CURDIR)/build

GO ?= go

SRCS := $(shell find . -type f -name '*.go' | grep -v ./vendor)

.PHONY: all
all: linux darwin

.PHONY: darwin
darwin: $(OUT)/$(BINARY)_darwin_amd64

.PHONY: linux
linux: $(OUT)/$(BINARY)_linux_amd64

$(OUT)/$(BINARY)_darwin_amd64: $(SRCS)
	GOOS=darwin GOARCH=amd64 $(GO) build -ldflags "$(LDFLAGS)" -v -o $@

$(OUT)/$(BINARY)_linux_amd64: $(SRCS)
	GOOS=linux GOARCH=amd64 GOARM=7 $(GO) build -ldflags "$(LDFLAGS)" -v -o $@

.PHONY: clean
clean:
	rm -frv $(OUT)
	go clean
