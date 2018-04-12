
.PHONY: base steamcmd games

default: base steamcmd games

base: 
	$(MAKE) -C base

steamcmd:
	$(MAKE) -C steamcmd

games:
	$(MAKE) -C games

clean:
	$(MAKE) -C base clean
	$(MAKE) -C steamcmd clean
	$(MAKE) -C games clean