.PHONY: all
all: build

.PHONY: build
build:
	rm -rf nvim-config
	cp -r ~/.config/nvim ./nvim-config
	docker build . -t nvim-docker
	rm -rf nvim-config

.PHONY: run
run:
	docker run -it --rm --name nvim-container -v $(pwd):/workspace nvim-docker
