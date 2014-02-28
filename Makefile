build:
	grunt build

deploy: build autocommit heroku push

autocommit:
	git add .
	git add -u
	git commit -am "built static assets"

forcepublish: heroku
	git push heroku `git subtree split --prefix dist master`:master --force

heroku:
	git subtree push --prefix dist heroku master

push:
	git push
