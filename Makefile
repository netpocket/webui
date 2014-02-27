build:
	grunt build

deploy: build publish

forcepublish:
	git push heroku `git subtree split --prefix dist master`:master --force

publish:
	git subtree push --prefix dist heroku master
