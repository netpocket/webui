build:
	grunt build

deploy: build publish

forcepublish: publish
	git push heroku `git subtree split --prefix dist master`:master --force

publish:
	cp heroku/* dist
	git subtree push --prefix dist heroku master
