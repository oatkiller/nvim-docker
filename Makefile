.PHONY: all
all: build

.PHONY: build
build:
	docker build . -t nvim-docker

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
