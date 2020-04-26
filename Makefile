# Makefile for noter, this could easily be adapted for any app.

PROJECT = noter
PID_FILE = /tmp/$(PROJECT).pid

testing:
	# get rid of this testing function later
	@echo $(PROJECT)
	@echo $(PID_FILE)

.PHONY: css cssmin build run restart watch

cssmin:
	@echo Compiling a purged and minified $(PROJECT).css
	@postcss css/$(PROJECT).css -o http/static/$(PROJECT).css

css:
	@echo Compiling a maximal \(all classes unused or not\) $(PROJECT).css
	@postcss css/$(PROJECT).css -o http/static/$(PROJECT).css --use tailwindcss 

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
