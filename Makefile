REPOSITORY := erwinnttdata
NAME := collectd
VERSION ?= 5.4.1-6_deb8u1_004

build: _build ##@targets Builds the docker image.

rebuild: _rebuild ##@targets Builds the docker image anew.

clean: _clean ##@targets Removes the docker image.

deploy: _deploy ##@targets Deploys the docker image to the repository.

DOCKER_ARGS := --privileged --net="host" -v "/home:/mnt/home:ro" -v "/dev:/mnt/dev:ro" -v "/proc:/mnt/proc:ro" -v "`realpath test-graphite/write_graphite.conf`:/mnt/collectd/collectd.conf.d/write_graphite.conf" --name $(NAME) $(REPOSITORY)/$(NAME):$(VERSION)

test-collectd:
	docker run -d $(DOCKER_ARGS)

test-collectd-consul:
	docker run -d -e "SERVICE_NAME=$(NAME)" --dns 172.17.0.1 $(DOCKER_ARGS)

test-collectd-bash:
	docker run -it --rm $(DOCKER_ARGS) bash

include Makefile.help
include Makefile.functions
include Makefile.image

.PHONY +: build rebuild clean deploy
