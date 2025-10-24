#!/usr/bin/env bash
set -euo pipefail
source /home/faisal/devops-cicd-lab/env/env.sh
az acr show -n "$AZ_ACR_NAME" -o table
