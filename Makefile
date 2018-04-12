
.PHONY: base steamcmd games

default: base steamcmd games

base: 
	$(MAKE) -C base

steamcmd:
	$(MAKE) -C steamcmd

games:
	$(MAKE) -C games

clean:
	$(MAKE) -C base
	$(MAKE) -C steamcmd
	$(MAKE) -C games