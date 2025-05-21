export DYLD_LIBRARY_PATH:=$(shell brew --prefix cairo)/lib:$(DYLD_LIBRARY_PATH)

all:
	DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) mkdocs serve

build:
	DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) mkdocs build

gh-deploy:
	DYLD_LIBRARY_PATH=$(DYLD_LIBRARY_PATH) mkdocs gh-deploy
	@echo
	@echo

deploy: clean gh-deploy
	git push origin gh-pages:main -f

commit:
	git add .
	git commit -m 'update'
	git push

clean:
	rm -rf .cache/

social: clean build
	open .cache/plugin/social