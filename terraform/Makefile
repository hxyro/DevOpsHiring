SHELL := /bin/bash

reconfigure:
	source .env; terraform init -reconfigure
upgrade:
	source .env; terraform init -upgrade
%:
	source .env; terraform $@ ${ARGS}