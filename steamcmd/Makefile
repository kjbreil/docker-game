NS = kjbreil

REPO = steamcmd

.PHONY: 

default: build

build:
	docker build -t $(NS)/$(REPO) .

clean:
	docker build --no-cache -t $(NS)/$(REPO) .

shell:
	docker run --rm --name lgsm-test -it $(NS)/$(REPO) /bin/bash

run:
	docker run --rm --name lgsm-test $(NS)/$(REPO)

push:
	docker push $(NS)/$(REPO)


