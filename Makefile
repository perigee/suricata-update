.PHONY: build fetch run

UNAME_S := $(shell uname -s)
UNAME_P := $(shell uname -p)
SURICATA_IMG := jasonish/suricata:7.0.10-arm64


ifeq ($(UNAME_S),Darwin)
	ifeq ($(UNAME_P),arm)
		DOCKER_CMD := nerdctl.lima
		MOUNT_ROOT := /tmp/lima/suricata
	endif
endif

ifeq ($(UNAME_S),Linux)
	ifeq ($(UNAME_P),x86_64)
		DOCKER_CMD := docker
		MOUNT_ROOT := $(PWD)
	endif
endif


build:
	#$(DOCKER_CMD) build --target runner -t mytmpsuricata:tmp -f Dockerfile .
	$(DOCKER_CMD) build --target runner -t mytmpsuricata:alma -f Dockerfile.alma .
	#$(DOCKER_CMD) build --target build -t mytmpsuricata:tmp -f Dockerfile .

fetch:
	$(DOCKER_CMD) run -it --rm --net=host --cap-add=net_admin \
		--cap-add=net_raw --cap-add=sys_nice \
		-v $(MOUNT_ROOT)/var/log/suricata:/var/log/suricata \
		-v $(MOUNT_ROOT)/etc/suricata:/etc/suricata \
		-v $(MOUNT_ROOT)/var/lib/suricata:/var/lib/suricata \
		$(SURICATA_IMG) suricata-update

run:
	$(DOCKER_CMD) run -ti --rm \
		-v $(MOUNT_ROOT)/var/log/suricata:/var/log/suricata \
		-v $(MOUNT_ROOT)/etc/suricata:/etc/suricata \
		-v $(MOUNT_ROOT)/var/lib/suricata:/var/lib/suricata \
		-v $(PWD)/disable.conf:/etc/suricata/disable.conf \
		-v $(PWD)/drop.conf:/etc/suricata/drop.conf \
		$(SURICATA_IMG) /bin/bash

# /bin/sh
# suricata-update update-sources
# suricata-update --on-reload ## will not reload in case the process suricata is not running

