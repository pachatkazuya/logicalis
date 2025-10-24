# DevOps CI/CD Lab — Azure (GitHub Actions + Azure DevOps)

Welcome! This lab is designed to teach CI/CD and DevOps **tiny bit by tiny bit**, hands-on and CLI-first.
You’ll build a minimal app, containerize it, push to **Azure Container Registry (ACR)**, and (later) deploy to **AKS** via Terraform & Helm.

We’ll progress in **phases**. Only move forward when each checkpoint is green.

---

## Phases

**Phase 0 — Bootstrap**
- Install prerequisites (Azure CLI, Docker, Git).
- Set environment variables (subscription, resource group, region, ACR name).

**Phase 1 — Minimal app + Docker**
- Hello World app (Node.js).
- Build & run locally (`docker build`, `docker run`).
- Add a basic unit test.

**Phase 2 — GitHub Actions: CI**
- On every push: run tests + build container image.
- (Preview) Push image to ACR via OIDC (no secrets).

**Phase 3 — Azure DevOps Pipelines: CI**
- Mirror the same pipeline in Azure DevOps yaml.
- Use a Service Connection (or OIDC) to Azure; push image to ACR.

**Phase 4 — Terraform: ACR (then AKS)**
- Provision Resource Group + ACR.
- Later add AKS + networking (hub/spoke optional).

**Phase 5 — CD to AKS (Helm)**
- Deploy the app image to AKS using a Helm chart.
- Blue/green or canary (optional).

**Phase 6 — Quality gates & security**
- Code scanning (CodeQL or SAST).
- Container scanning (Trivy).
- Policy checks (OPA/Conftest) + Terraform fmt/validate/plan gates.

**Phase 7 — FinOps**
- Image retention, ACR cleanup.
- Build cache, right-sized runners, artifact pruning.

**Phase 8 — Operations**
- Rollback strategy, health probes, alerts, dashboards.

---

## Quick Start

```bash
# 1) Set your Azure subscription in env/env.sh, then:
source /home/faisal/devops-cicd-lab/env/env.sh

# 2) Bootstrap login + subscription
make az-bootstrap

# 3) Create Resource Group + ACR (Terraform)
make tf-init
make tf-apply

# 4) Build and test locally
make app-test
make image-build

# 5) (Optional) Login to ACR and push
make acr-login
make image-push
```

> When you’re ready, move to **Phase 2**: connect this repo to GitHub and enable the **Actions** workflow in `.github/workflows/build.yml`.

---

## Repo Structure

```
devops-cicd-lab/
├─ app/                      # sample app + Dockerfile + tests
├─ env/                      # environment variables (source this)
├─ scripts/                  # helper scripts (login, acr, etc.)
├─ terraform/                # infra as code (RG + ACR now; AKS later)
└─ .github/workflows/        # GitHub Actions CI pipeline
```

---

## Notes
- This lab assumes **WSL Ubuntu** and a CLI-first workflow.
- Do not store secrets in files. We’ll use **OIDC** for GitHub → Azure auth later.
- Use **absolute path** to source env: `source /home/faisal/devops-cicd-lab/env/env.sh`.
