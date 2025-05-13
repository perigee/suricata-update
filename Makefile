UNAME_S := $(shell uname -s)
UNAME_P := $(shell uname -p)



ifeq ($(UNAME_S),Darwin)
	ifeq ($(UNAME_P),arm)
		DOCKER_CMD := nerdctl.lima
		MOUNT_ROOT := /tmp/lima/
	endif
endif

ifeq ($(UNAME_S),Linux)
	ifeq ($(UNAME_P),x86_64)
		DOCKER_CMD := docker
		MOUNT_ROOT := $(PWD)
	endif
endif

all:
	@echo $(DOCKER_CMD)


