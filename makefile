
dev-build:
	echo $$(./bin/download_data.sh)


local-build:
	@echo "Download local cryoEM data:"
	mkdir testfiles
	if [! -f smartscope_testfiles.tar.gz] ; \
	then \
	wget docs.smartscope.org/downloads/smartscope_testfiles.tar.gz; \
	fi;
	tar -xvf smartscope_testfiles.tar.gz -C testfiles --strip-components=1
	@echo "Create and Run SmartScope containers as ${UID}:${GID} in local:"
	UID=${id -u} GID=${id -g} docker compose -f docker-compose.local.yml up -d

local-restart:
	@echo "Restart SmartScope containers as ${UID}:${GID} in DEV:"
	UID=${id -u} GID=${id -g} docker compose -f docker-compose.local.yml up -d

local-stop:
	@echo "Stop SmartScope containers in local:"
	UID=${id -u} GID=${id -g} docker compose  -f docker-compose.local.yml down
	@sudo rm -fr backups db logs shared testfiles

prod-start:
	@echo "Create/Run/Restart SmartScope containers as ${UID}:${GID} in PROD:"
	sudo docker compose -f docker-compose.yml up -d

prod-stop:
	@echo "Stop SmartScope containers in PROD:"
	sudo docker compose  -f docker-compose.yml down
