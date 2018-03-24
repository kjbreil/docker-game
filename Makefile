
.PHONY: base steamcmd games

default: base steamcmd games

base: 
	$(MAKE) -C base

steamcmd:
	$(MAKE) -C steamcmd

games:
	$(MAKE) -C games


