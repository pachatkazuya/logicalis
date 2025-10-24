SHELL := /bin/bash

include env/env.sh
export

.DEFAULT_GOAL := help

help:
	@echo "Targets:"
	@echo "  az-bootstrap    - az login, set subscription"
	@echo "  tf-init         - terraform init (RG+ACR)"
	@echo "  tf-apply        - terraform apply -auto-approve"
	@echo "  tf-destroy      - terraform destroy -auto-approve"
	@echo "  app-test        - run unit tests"
	@echo "  image-build     - docker build local image"
	@echo "  acr-login       - az acr login"
	@echo "  image-push      - docker tag + push to ACR"

az-bootstrap:
	az account show >/dev/null 2>&1 || az login -o none
	az account set --subscription $(AZ_SUBSCRIPTION_ID)

tf-init:
	cd terraform && terraform init

tf-apply:
	cd terraform && terraform apply -auto-approve -var "location=$(AZ_LOCATION)" -var "resource_group=$(AZ_RESOURCE_GROUP)" -var "acr_name=$(AZ_ACR_NAME)"

tf-destroy:
	cd terraform && terraform destroy -auto-approve -var "location=$(AZ_LOCATION)" -var "resource_group=$(AZ_RESOURCE_GROUP)" -var "acr_name=$(AZ_ACR_NAME)"

app-test:
	cd app && npm ci && npm test

image-build:
	cd app && docker build -t $(IMAGE_NAME) .

acr-login:
	az acr login --name $(AZ_ACR_NAME)

image-push:
	@ACR_LOGIN_SERVER=$$(az acr show -n $(AZ_ACR_NAME) --query loginServer -o tsv); \
	docker tag $(IMAGE_NAME) $$ACR_LOGIN_SERVER/$(IMAGE_NAME); \
	docker push $$ACR_LOGIN_SERVER/$(IMAGE_NAME); \
	echo "Pushed: $$ACR_LOGIN_SERVER/$(IMAGE_NAME)"
