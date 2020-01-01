PREFIX?=/usr/local
_INSTDIR=${DESTDIR}${PREFIX}
BINDIR?=${_INSTDIR}/bin
MANDIR?=${_INSTDIR}/share/man
APP=devc

.PHONY: all
all: build

.PHONY: build
## build: Build the application
build:
	@echo "Building..."
	@go build -o ${APP} main.go

.PHONY: install
## install: Install the application
install:
	@echo "Installing..."
	@install -t ${BINDIR}/ ${APP}

.PHONY: uninstall
## uninstall: Uninstall the application
uninstall:
	@echo "Uninstalling..."
	@rm -rf ${BINDIR}/${APP}

.PHONY: run
## run: Runs go run main.go
run:
	go run -race main.go

.PHONY: clean
## clean: Cleans the binary
clean:
	@echo "Cleaning..."
	@rm -rf ${APP}

.PHONY: setup
## setup: Setup go modules
setup:
	@-go mod init
	@go mod tidy
	@go mod vendor

.PHONY: lint
## lint: Runs golint linter on the project
lint:
	@golint .

.PHONY: format
## format: Runs goimports on the project
format:
	@goimports -l -w .

.PHONY: help
## help: Prints this help message
help:
	@echo "Usage: \n"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
