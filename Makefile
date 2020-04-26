# Makefile for noter, this could easily be adapted for any app.

PROJECT = noter
PID_FILE = /tmp/$(PROJECT).pid

testing:
	# get rid of this testing function later
	@echo $(PROJECT)
	@echo $(PID_FILE)

.PHONY: css cssdev cssall build run restart watch

css:
	@echo Compiling a purged and minified production $(PROJECT).css
	@postcss css/$(PROJECT).css -o http/static/$(PROJECT).css

cssdev:
	@echo Compiling a maximal with comments $(PROJECT).css
	@postcss css/$(PROJECT).css -o http/static/$(PROJECT).css --use tailwindcss 

cssall:
	@echo Compiling a maximal but minified $(PROJECT).css
	@postcss css/$(PROJECT).css -o http/static/$(PROJECT).all.css 

kill: 
	-kill `cat $(PID_FILE)`
	-rm $(PID_FILE)

build:
	go build -o $(PROJECT) cmd/main.go

run:
	./$(PROJECT) & echo $$! > $(PID_FILE)

restart: kill build run 
	@echo Restarting server.

watch: 
	@echo Reloading server when source changes...
	@chokidar "**/*.go" "**/*.html" --ignore "node_modules" --ignore ".git" --ignore "$(PROJECT)" \
		--verbose --initial -c "make restart"
