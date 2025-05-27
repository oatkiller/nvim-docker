.PHONY: all
all: build

.PHONY: build
build:
	docker build . -t nvim-docker

.PHONY: run
run:
	docker run -it --rm --name nvim-container -v $(shell pwd):/workspace nvim-docker

