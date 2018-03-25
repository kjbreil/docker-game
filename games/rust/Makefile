NS = kjbreil

REPO = rust-server:TESTING

PORTS = -p 28016:28016/tcp -p 28015:28015/tcp -p 28015:28015/udp

.PHONY: 

default: build

build:
	docker build -t $(NS)/$(REPO) .

clean:
	docker build --no-cache -t $(NS)/$(REPO) .

entrypoint:
	docker run --rm $(PORTS) -v $(CURDIR):/docker --name lgsm-test -it $(NS)/$(REPO)	shell

interactive:
	docker run --rm --name lgsm-test -it $(NS)/$(REPO)

shell:
	docker run --rm --name lgsm-test -it $(NS)/$(REPO) /bin/bash

run:
	docker run --rm -it $(PORTS) --name lgsm-test $(NS)/$(REPO)

push:
	docker push $(NS)/$(REPO)

