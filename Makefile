build:
	grunt build

deploy: build autocommit push_heroku push_origin

autocommit:
	git add .
	git add -u
	git commit -am "built static assets"

push_heroku:
	git push heroku `git subtree split --prefix dist master`:master --force
	#git subtree push --prefix dist heroku master

push_origin:
	git push
