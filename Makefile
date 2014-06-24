.PHONY: dev run build test

dev:
	pm2 start processes/development.json

run:
	pm2 start processes/production.json

build:
	npm i -g pm2 grunt-cli && npm i

test:
	NODE_ENV=test \
	./node_modules/.bin/mocha \
	--reporter nyan \
	--compilers coffee:coffee-script \
	--check-leaks \
	--slow 20 \
	tests

