
local-start:
	@echo "Create/Run/Restart SmartScope containers as ${UID}:${GID} in DEV:"
	UID=${id -u} GID=${id -g} docker compose -f docker-compose.local.yml up -d

local-stop:
	@echo "Stop SmartScope containers in DEV:"
	UID=${id -u} GID=${id -g} docker compose  -f docker-compose.local.yml down
	@sudo rm -fr backups db logs shared testfiles

prod-start:
	@echo "Create/Run/Restart SmartScope containers as ${UID}:${GID} in PROD:"
	sudo docker compose -f docker-compose.yml up -d

prod-stop:
	@echo "Stop SmartScope containers in PROD:"
	sudo docker compose  -f docker-compose.yml down
