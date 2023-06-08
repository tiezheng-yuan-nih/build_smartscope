help:
	@echo "------------------------"
	./smartscope.local.sh -h
	@echo "------------------------"
	./smartscope.sh -h
	@echo "------------------------"

local-start:
	sudo ./smartscope.local.sh start

local-stop:
	sudo ./smartscope.local.sh stop

prod-start:
	sudo ./smartscope.sh start

prod-stop:
	sudo ./smartscope.sh stop
