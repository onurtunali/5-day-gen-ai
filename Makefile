.PHONY: clean data lint requirements sync_data_to_s3 sync_data_from_s3

#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
BUCKET = projects
PROJECT_NAME = 5-day-gen-ai
PYTHON_INTERPRETER = python3
IMAGE_NAME = 5-day-gen-ai
VERSION = latest


ifeq (,$(shell which conda))
HAS_CONDA=False
else
HAS_CONDA=True
endif

#################################################################################
# COMMANDS                                                                      #
#################################################################################

## Setup virtual environment, check conda 
create_environment:
ifeq (True,$(HAS_CONDA))
	mamba env create --file environment.yml
else
	@echo "No conda found!"
endif

## Clean compiled or byte files
clean:
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name ".ipynb_checkpoints" -delete

## Retrieve Kaggle dataset 
kaggle:
	kaggle datasets download asaniczka/amazon-products-dataset-2023-1-4m-products -p data/

## Upload data to s3 bucket
sync_data_to_s3:
	aws s3 sync data/ s3://$(BUCKET)/data/  --exclude "*.DS_Store"
	aws s3 rm s3://$(BUCKET)/data/ --recursive --exclude "*" --include "*.DS_Store"

## Download data from s3 bucket
sync_data_from_s3:
	aws s3 sync s3://$(BUCKET)/data/ data/

## Upload models from s3 bucket
sync_models_to_s3:
	aws s3 sync models/ s3://$(BUCKET)/models/ --exclude "*.DS_Store*"

## Download models from s3 bucket 
sync_models_from_s3:
	aws s3 sync s3://$(BUCKET)/models/ models/

## Build Docker image
db:
	docker build . -t ${PROJECT_NAME}:latest

## Run Docker image
dr:
	docker run --rm -p 8000:8000 --name $(PROJECT_NAME) ${PROJECT_NAME}:latest

## Build and run Docker image
dbr:
	docker build . -t ${PROJECT_NAME}:latest
	docker run --rm -p 8000:8000 --name $(PROJECT_NAME) ${PROJECT_NAME}:latest


#################################################################################
# PROJECT RULES                                                                 #
#################################################################################

#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

# Inspired by <http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
# sed script explained:
# /^##/:
# 	* save line in hold space
# 	* purge line
# 	* Loop:
# 		* append newline + line to hold space
# 		* go to next line
# 		* if line starts with doc comment, strip comment character off and loop
# 	* remove target prerequisites
# 	* append hold space (+ newline) to line
# 	* replace newline plus comments by `---`
# 	* print line
# Separate expressions are necessary because labels cannot be delimited by
# semicolon; see <http://stackoverflow.com/a/11799865/1968>
.PHONY: help
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')
