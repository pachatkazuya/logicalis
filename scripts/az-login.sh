#!/usr/bin/env bash
set -euo pipefail
source /home/faisal/devops-cicd-lab/env/env.sh
az account show >/dev/null 2>&1 || az login -o none
az account set --subscription "$AZ_SUBSCRIPTION_ID"
echo "Logged in to subscription: $AZ_SUBSCRIPTION_ID"
