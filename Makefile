.PHONY: all
all: build

.PHONY: build
build:
	docker build . -t nvim-docker

.PHONY: build-multi
build-multi:
	docker buildx build --platform linux/amd64,linux/arm64 . -t nvim-docker

.PHONY: build-amd64
build-amd64:
	docker build --platform linux/amd64 . -t nvim-docker:amd64

.PHONY: build-arm64
build-arm64:
	docker build --platform linux/arm64 . -t nvim-docker:arm64

.PHONY: run
run:
	docker run -it --rm --name nvim-container -v ${PWD}:/workspace nvim-docker

.PHONY: install
install:
	mkdir -p ~/.local/bin
	cp ./scripts/nvim-docker ~/.local/bin/nvim-docker
	chmod +x ~/.local/bin/nvim-docker

checkhealth:
	docker run --rm \
		-v $(shell pwd)/nvim-config:/root/.config/nvim \
		-v $(shell pwd)/pack:/root/.config/nvim/pack \
		nvim-docker \
		nvim --headless -c "checkhealth oathealth" -c "q"

.PHONY: build run
