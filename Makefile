# Makefile for noter, this could easily be adapted for any app.

PROJECT = noter
PID_FILE = /tmp/$(PROJECT).pid

.PHONY: css cssdev cssall kill build run restart watch watchall

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
	# byproduct occasionally left, I'm running WSL2/VSCODE
	# -killall cmd
	# -rm $(PROJECT)

build:
	@go build -o $(PROJECT) cmd/main.go

run:
	./$(PROJECT) & echo $$! > $(PID_FILE)

restart: kill build run 
	@echo Restarting server.

watch: 
	@echo Reloading server only when Go source changes...
	@chokidar "**/*.go" --ignore "node_modules" --ignore ".git" --ignore "$(PROJECT)" \
		--verbose --initial -c "make -s restart"

watchall: 
	@echo Reloading server when Go source **and** html changes, rebuilding CSS too
	@chokidar "**/*.go" "**/*.html" --ignore "node_modules" --ignore ".git" --ignore "$(PROJECT)" \
		--verbose --initial -c "make css restart"
