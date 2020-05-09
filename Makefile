# Development Makefile for noter, a Go language application.

export PROJECT = noter
PID_FILE = /tmp/$(PROJECT).pid

# Keeping config simple for dev and production:
# Include as environment variables for the make process an .env environment file if it exists.
-include $(PROJECT).env
export
# Example noter.env file
# NOTE: .env files should not get committed to source control. 
#
# Uncomment and adjust if needed:
# PREFIX=NOTER
#
# Uncomment zero, one or more of the following:
# $(PREFIX)_HOST = 0.0.0.0
# $(PREFIX)_PORT = 8080
# $(PREFIX)_DBPATH = /tmp/$(PROJECT)-dev.db
# $(PREFIX)_STATIC = = /home/$(USER)/go/src/github.com/solutionroute/noter/http/static
# $(PREFIX)_TEMPLATES = /home/$(USER)/go/src/github.com/solutionroute/noter/http/templates
# (PREFIX)_SECRET = YouWouldChangeThIsOfCourse
## end of .env file ##

.PHONY: css cssdev cssall kill build run restart watch watchall

testing: 
	env

css:
	@echo Compiling a purged and minified production $(PROJECT).css
	@postcss css/$(PROJECT).css -o http/static/$(PROJECT).css

cssdev:
	@echo Compiling for development a maximal with comments $(PROJECT).css
	@postcss css/$(PROJECT).css -o http/static/$(PROJECT).css --use tailwindcss 

cssall:
	@echo Compiling a maximal but minified $(PROJECT).css
	@postcss css/$(PROJECT).css -o http/static/$(PROJECT).all.css 

kill: 
	-kill `cat $(PID_FILE)`
	-rm $(PID_FILE)

build:
	@go build -o $(PROJECT) cmd/main.go

run:
	go run cmd/main.go & echo $$! > $(PID_FILE)

restart: kill run 
	@echo Restarting server.

watch: 
	# starts server and watches and restarts on .go file changes.
	# You should have run "npm install" to ensure chokidar and CSS processing tools are installed
	@echo Reloading server only when Go source changes...
	@chokidar "**/*.go" --ignore "node_modules" --ignore ".git" --ignore "$(PROJECT)" \
		--verbose --initial -c "make -s restart"

watchall: 
	# TODO remove this unless a decision is made to cache HTML templates. Currently templates
	# are re-read for every request to make adaptation easy.
	@echo Reloading server when Go source **and** html changes, rebuilding CSS too
	@chokidar "**/*.go" "**/*.html" --ignore "node_modules" --ignore ".git" --ignore "$(PROJECT)" \
		--verbose --initial -c "make css restart"
