.DEFAULT_GOAL := help
.PHONY : resources

image: ## Construir la imagen de node: make image
	docker build -t "percytataje10/node:8" docker/node

run:
	docker run -it --rm  $(PORT) -v $(PWD):/app -w /app/frontend percytataje10/node:8 $(NODE_COMMAND)

install: ## Instalar dependencias: make install
	@make run \
	NODE_COMMAND='yarn install'

watch: ## Levantar el prooyecto en el puerto 3000: make watch
	@make run \
	NODE_COMMAND='yarn start' \
	PORT='-p 3000:3000'

build: ## Construir el compilado: make build
	@make run \
	NODE_COMMAND='yarn build'

buildprod: ## Construir y levantar el server: make buildprod
	@make run \
	NODE_COMMAND='yarn buildprod'

server: ## levantar el server: make server
	@make run \
	NODE_COMMAND='yarn server'
	

## Target Help ##
help:
	@printf "\033[31m%-22s %-59s %s\033[0m\n" "Target" " Help" "Usage"; \
	printf "\033[31m%-22s %-59s %s\033[0m\n"  "------" " ----" "-----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-22s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'
