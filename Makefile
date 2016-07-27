BINARY = s3-get-presigned-url

OUT = $(CURDIR)/build

GO ?= go

SRCS := $(shell find . -type f -name '*.go' | grep -v ./vendor)

.PHONY: all
all: linux darwin

.PHONY: darwin
darwin: $(OUT)/darwin/$(BINARY)

.PHONY: linux
linux: $(OUT)/linux/$(BINARY)

$(OUT)/darwin/$(BINARY): $(SRCS)
	GOOS=darwin GOARCH=amd64 $(GO) build -ldflags "$(LDFLAGS)" -v -o $@

$(OUT)/linux/$(BINARY): $(SRCS)
	GOOS=linux GOARCH=arm GOARM=7 $(GO) build -ldflags "$(LDFLAGS)" -v -o $@

.PHONY: clean
clean:
	rm -frv $(OUT)
	go clean
