#!/usr/bin/env bash
# Absolute path sourcing is preferred.
# Update these before running 'make' targets.
export AZ_SUBSCRIPTION_ID="89edcdcf-5d7b-4dd7-a8fa-d8d194731526"  # replace if needed
export AZ_LOCATION="southeastasia"
export AZ_RESOURCE_GROUP="rg-devops-lab"
export AZ_ACR_NAME="acrdevopslab2025"
export PROJECT_DIR="/home/faisal/devops-cicd-lab"
export APP_NAME="hello-web"
export IMAGE_TAG="v0.1.0"

# Derived
export IMAGE_NAME="${APP_NAME}:${IMAGE_TAG}"
