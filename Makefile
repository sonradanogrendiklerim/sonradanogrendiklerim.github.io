all:
	mkdocs serve

build:
	mkdocs build

gh-deploy:
	mkdocs gh-deploy
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